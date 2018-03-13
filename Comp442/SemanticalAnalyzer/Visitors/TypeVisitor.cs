using Errors;
using SyntacticAnalyzer.Nodes;
using SyntacticAnalyzer.Semantics;
using System.Linq;

namespace SemanticalAnalyzer.Visitors
{
    public class TypeVisitor : Visitor
    {
        private SymbolTable _functionScope;
        private SymbolTable _globalScope;

        public TypeVisitor(SymbolTable globalScope)
        {
            this._globalScope = globalScope;
        }

        public override void PreVisit(FuncDef funcDef)
        {
            this._functionScope = funcDef.Entry.Link;
        }

        public override void PreVisit(MainStatBlock statBlock)
        {
            this._functionScope = statBlock.Table;
        }


        public override void Visit(AddOp addOp)
        {
            if (addOp.RHS is Node rhs) {
                if (addOp.LHS is Node lhs) {
                    if (lhs.SemanticalType != rhs.SemanticalType) {
                        ErrorManager.Add($"Inconsistent types: Expected {lhs.SemanticalType}, got {rhs.SemanticalType}", rhs.Location);
                    } else {
                        addOp.SemanticalType = lhs.SemanticalType;
                    }
                } else {
                    addOp.SemanticalType = rhs.SemanticalType;
                }
            } else {
                ErrorManager.Add("RHS does not exist.", addOp.Location);
            }
        }

        public override void Visit(FCall fCall)
        {
            
        }

        public override void Visit(DataMember dataMember)
        {
            
        }

        public override void Visit(Not not)
        {
            
        }

        public override void Visit(MultOp multOp)
        {
            
        }

        public override void Visit(RelExpr relExpr)
        {
            
        }

        public override void Visit(ReturnStat returnStat)
        {
            
        }

        public override void Visit(Sign sign)
        {
            
        }

        public override void Visit(Var var)
        {
            SymbolTable currentScope = new SymbolTable();
            currentScope.AddRange(this._functionScope.GetAll());
            currentScope.AddRange(this._globalScope.GetAll());

            foreach (var element in var.Elements) {
                if (element is AParams aparams) {
                    // TODO
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
                        ErrorManager.Add($"Too many indices for {dataMember.Id}. Got {expectedNumParams}, expected {actualNumParams}", dataMember.Location);
                        break;
                    }

                    var.SemanticalType = entry.Type.Replace("[]", string.Empty) + "[]".Repeat(diffIndices);

                    currentScope = new SymbolTable();
                    currentScope.AddRange(_globalScope.Get($"{var.SemanticalType}-{Classification.Class}")?.Link?.GetAll());
                }

                if (element is FCall fcall) {
                    TableEntry entry = currentScope.Get($"{fcall.Id}-{Classification.Function}");

                    var types = entry.Type.Split('-');
                    string returnType = types[0];
                    var parameters = types[1] == "" ? new string[0] : types[1].Split(',');

                    if (parameters.Length == fcall.Parameters.Expressions.Count) {
                        bool valid = true;
                        for (int i = 0; i < parameters.Length; i++) {
                            string expectedType = parameters[i];

                            var expression = fcall.Parameters.Expressions[i] as Node;
                            if (expression != null) {

                                string actualType = expression.SemanticalType;

                                if (actualType != expectedType) {
                                    valid = false;
                                    ErrorManager.Add($"Invalid parameter type: Expected {expectedType}, got {actualType}", expression.Location);
                                    break;
                                }

                            } else {
                                throw new System.Exception();
                            }
                        }

                        if (valid) {
                            var.SemanticalType = returnType;
                        }
                    } else {
                        ErrorManager.Add($"The function {fcall.Id} takes in {parameters.Length} arguments.", fcall.Location);
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
                } else {
                    assignStat.SemanticalType = expression.SemanticalType;
                }
            } else {
                ErrorManager.Add($"Could not establish an expression value.", assignStat.Location);
            }
        }
    }
}
