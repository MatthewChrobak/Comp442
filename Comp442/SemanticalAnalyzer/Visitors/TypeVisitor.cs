using Errors;
using SyntacticAnalyzer.Nodes;
using SyntacticAnalyzer.Semantics;
using System.Collections.Generic;
using System.Linq;

namespace SemanticalAnalyzer.Visitors
{
    public class TypeVisitor : Visitor
    {
        private SymbolTable _functionScope;
        private SymbolTable _globalScope;
        private SymbolTable _classInstanceScope;

        private Stack<string> _forDecl = new Stack<string>();

        private string _lastFunctionRequiredReturnType;

        public TypeVisitor(SymbolTable globalScope)
        {
            this._globalScope = globalScope;
        }

        public override void PreVisit(FuncDef funcDef)
        {
            this._lastFunctionRequiredReturnType = funcDef.ReturnType;
            this._functionScope = funcDef.Entry.Link;

            if (funcDef.ScopeResolution != null) {
                this._classInstanceScope = this._globalScope.Get($"{funcDef.ScopeResolution.ID}-{Classification.Class}")?.Link;
            }
        }

        public override void PreVisit(MainStatBlock statBlock)
        {
            this._lastFunctionRequiredReturnType = "__MAIN__";
            this._functionScope = statBlock.Table;
            this._classInstanceScope = new SymbolTable();
        }
   


        public override void Visit(AddOp addOp)
        {
            if (addOp.RHS is Node rhs) {
                if (addOp.LHS is Node lhs) {

                    if (lhs.SemanticalType != rhs.SemanticalType) {
                        ErrorManager.Add($"Inconsistent types: Cannot perform {lhs.SemanticalType} {addOp.Operator} {rhs.SemanticalType}", addOp.Location);
                    }
                }
                addOp.SemanticalType = rhs.SemanticalType;
            } else {
                ErrorManager.Add("There is no RHS for this add operation.", addOp.Location);
            }
        }

        public override void Visit(Not not)
        {
            not.SemanticalType = ((Node)not.Factor).SemanticalType;
        }

        public override void Visit(MultOp multOp)
        {
            if (multOp.RHS is Node rhs) {
                if (multOp.LHS is Node lhs) {

                    if (lhs.SemanticalType != rhs.SemanticalType) {
                        ErrorManager.Add($"Inconsistent types: Cannot perform {lhs.SemanticalType} {multOp.Operator} {rhs.SemanticalType}", multOp.Location);
                    }
                }
                multOp.SemanticalType = rhs.SemanticalType;
            } else {
                ErrorManager.Add("There is no RHS for this multiplication operation.", multOp.Location);
            }
        }

        public override void Visit(RelExpr relExpr)
        {
            if (relExpr.RHS is Node rhs) {
                if (relExpr.LHS is Node lhs) {
                    if (lhs.SemanticalType != rhs.SemanticalType) {
                        ErrorManager.Add($"Inconsistent types: Cannot perform {lhs.SemanticalType} {relExpr.RelationOperator} {rhs.SemanticalType}", relExpr.Location);
                    }
                }
                relExpr.SemanticalType = rhs.SemanticalType;
            } else {
                ErrorManager.Add("There is no RHS for this relational expression.", relExpr.Location);
            }
        }

        public override void Visit(ReturnStat returnStat)
        {
            returnStat.SemanticalType = ((Node)returnStat.ReturnValueExpression).SemanticalType;

            if (this._lastFunctionRequiredReturnType == "__MAIN__") {
                ErrorManager.Add("Cannot return in main.", returnStat.Location);
                return;
            }

            if (this._lastFunctionRequiredReturnType != returnStat.SemanticalType) {
                ErrorManager.Add($"Must return a value of type {this._lastFunctionRequiredReturnType}. Cannot convert {returnStat.SemanticalType} to it.", returnStat.Location);
            }
        }

        public override void Visit(Sign sign)
        {
            sign.SemanticalType = ((Node)sign.Factor).SemanticalType;
        }

        public override void Visit(Var var)
        {
            SymbolTable currentScope = new SymbolTable();
            currentScope.AddRange(this._functionScope.GetAll(), var.Location);
            currentScope.AddRange(this._globalScope.GetAll(), var.Location);
            currentScope.AddRange(this._classInstanceScope?.GetAll(), var.Location);

            foreach (var element in var.Elements) {
                if (element is AParams aparams) {
                    throw new System.Exception();
                }

                if (element is DataMember dataMember) {
                    TableEntry entry = null;
                    if (currentScope.Get($"{dataMember.Id}-{Classification.Variable}") is TableEntry vEntry) {
                        entry = vEntry;
                    } else if (currentScope.Get($"{dataMember.Id}-{Classification.Parameter}") is TableEntry pEntry) {
                        entry = pEntry;
                    } else {
                        ErrorManager.Add($"The {Classification.Variable} {dataMember.Id} could not be resolved.", dataMember.Location);
                        break;
                    }

                    int actualNumParams;
                    if (dataMember.Indexes == null) {
                        actualNumParams = 0;
                    } else {
                        actualNumParams = dataMember.Indexes.Expressions.Count;
                    }
                    int expectedNumParams = entry.Type.Count(val => val == '[');
                    int diffIndices = expectedNumParams - actualNumParams;

                    if (diffIndices < 0) {
                        ErrorManager.Add($"Too many indices for {dataMember.Id}. Got {actualNumParams}, expected {expectedNumParams}", dataMember.Location);
                        break;
                    }

                    for (int i = 0; i < actualNumParams && i < expectedNumParams; i++) {
                        var exp = dataMember.Indexes.Expressions[i] as Node;
                        if (exp.SemanticalType != "int") {
                            ErrorManager.Add($"Index must be of type int and not {exp.SemanticalType}.", exp.Location);
                        }
                    }

                    var.SemanticalType = entry.Type.Replace("[]", string.Empty) + "[]".Repeat(diffIndices);

                    currentScope = new SymbolTable();
                    currentScope.AddRange(_globalScope.Get($"{var.SemanticalType}-{Classification.Class}")?.Link?.GetAll(), var.Location);
                }

                if (element is FCall fcall) {
                    TableEntry entry = currentScope.Get($"{fcall.Id}-{Classification.Function}");
                    
                    if (entry != null) {
                        var types = entry.Type.Split('-');
                        string returnType = types[0];
                        var parameters = types[1] == "" ? new string[0] : types[1].Split(',');

                        if (parameters.Length == fcall.Parameters.Expressions.Count) {

                            for (int i = 0; i < parameters.Length; i++) {
                                string expectedType = parameters[i];

                                var expression = fcall.Parameters.Expressions[i] as Node;
                                if (expression != null) {

                                    string actualType = expression.SemanticalType;

                                    if (actualType != expectedType) {
                                        ErrorManager.Add($"Invalid parameter type: Expected {expectedType}, got {actualType}", expression.Location);
                                        break;
                                    }

                                } else {
                                    throw new System.Exception();
                                }
                            }

                            var.SemanticalType = returnType;

                            if (entry.Link == null) {
                                ErrorManager.Add($"The function {fcall.Id} is not linked.", fcall.Location);
                                //break;
                            }

                            currentScope = new SymbolTable();
                            currentScope.AddRange(_globalScope.Get($"{var.SemanticalType}-{Classification.Class}")?.Link?.GetAll(), var.Location);

                        } else {
                            ErrorManager.Add($"The function {fcall.Id} takes in {parameters.Length} arguments.", fcall.Location);
                            var.SemanticalType = returnType;
                            break;
                        }

                    } else {
                        ErrorManager.Add($"The function {fcall.Id} could not be found or does not exist.", fcall.Location);
                        break;
                    }
                }
            }
        }

        public override void Visit(AssignStat assignStat)
        {
            if (assignStat.ExpressionValue is Node expression) {
                if (assignStat.Variable.SemanticalType != expression.SemanticalType) {
                    ErrorManager.Add($"Could not convert {expression.SemanticalType} to a {assignStat.Variable.SemanticalType}.", assignStat.Location);
                }
                assignStat.SemanticalType = expression.SemanticalType;
            } else {
                ErrorManager.Add($"Could not establish an expression value.", assignStat.Location);
            }
        }


        public override void PreVisit(ForStat forStat)
        {
            if (this._functionScope.Get($"{forStat.Id}-{Classification.Variable}") == null) {
                this._forDecl.Push(forStat.Id + forStat.Location);
            }

            this._functionScope.Add(new TableEntry(forStat.Id, Classification.Variable) {
                Type = forStat.Type
            }, forStat.IdLocation);
        }

        public override void Visit(ForStat forStat)
        {
            if (this._forDecl.Count == 0) {
                return;
            }

            if (this._forDecl.Peek() == forStat.Id + forStat.Location) {
                this._forDecl.Pop();
                this._functionScope.Remove(forStat.Id, Classification.Variable);
            }
        }

        public override void Visit(VarDecl varDecl)
        {
            if (varDecl.Type == "float" || varDecl.Type == "int") {
                return;
            }

            if (this._globalScope.Get($"{varDecl.Type}-{Classification.Class}") == null) {
                ErrorManager.Add($"The type {varDecl.Type} could not be found or does not exist.", varDecl.Location);
            }
        }
    }
}
