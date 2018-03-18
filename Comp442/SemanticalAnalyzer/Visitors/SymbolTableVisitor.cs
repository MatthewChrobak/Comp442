using SyntacticAnalyzer.Nodes;
using SyntacticAnalyzer.Semantics;
using System.Linq;

namespace SemanticalAnalyzer.Visitors
{
    public class SymbolTableVisitor : Visitor
    {
        private SymbolTable GlobalScope;

        public override void Visit(Program node)
        {
            this.GlobalScope = new SymbolTable();

            if (node.Classes != null) {
                foreach (var @class in node.Classes.Classes) {
                    this.GlobalScope.Add(new TableEntry(@class.ClassName, Classification.Class) {
                        Link = @class.Table
                    }, @class.Location);
                 }
            }

            if (node.Functions != null) {
                foreach (var func in node.Functions.Functions) {
                    this.GlobalScope.Add(func.Entry, func.Location);
                }
            }

            this.GlobalScope.Add(new TableEntry("main", Classification.Function) {
                Link = node.MainFunction.Table
            }, node.MainFunction.Location);

            node.Table = this.GlobalScope;
        }
        

        public override void Visit(ClassDecl classDecl)
        {
            var classTable = new SymbolTable();

            foreach (var entry in classDecl.Members) {
                if (entry as VarDecl != null) {
                    var variable = entry as VarDecl;
                    classTable.Add(new TableEntry(variable.Id, Classification.Variable) {
                        Link = variable.Table,
                        Type = variable.Type + "[]".Repeat(variable.Dimensions.Count)
                    }, variable.Location);
                    continue;
                }
                if (entry as FuncDecl != null) {
                    var func = entry as FuncDecl;
                    classTable.Add(new TableEntry(func.Id, Classification.Function) {
                        Link = func.Table,
                        Type = func.Type + "-" + string.Join(",", func.Parameters.Where(val => val.Id != string.Empty).Select(val => val.Type + "[]".Repeat(val.Dimensions.Count)))
                    }, func.Location);
                    continue;
                }
            }

            classDecl.Table = classTable;
        }

        public override void Visit(VarDecl var)
        {
        }


        public override void Visit(FuncDef funcDef)
        {
            string funcName = funcDef.FunctionName;

            if (funcDef.ScopeResolution != null) {
                funcName = $"{funcDef.ScopeResolution.ID}::{funcName}";
            }

            var entry = new TableEntry(funcName, Classification.Function);
            entry.Link = new SymbolTable();

            if (funcDef.Parameters != null) {
                foreach (var param in funcDef.Parameters) {
                    entry.Link.Add(param.Entry, param.Location);
                }
            }
            
            if (funcDef.Implementation?.Table != null) {
                foreach (var varEntry in funcDef.Implementation.Table.GetAll()) {
                    entry.Link.Add(varEntry, funcDef.Implementation.Location);
                }
            }

            entry.Type = funcDef.ReturnType + "-";
            if (funcDef.Parameters != null) {
                entry.Type += string.Join(",", funcDef.Parameters.Where(val => val.Id != string.Empty).Select(val => val.Type + "[]".Repeat(val.Dimensions.Count)));
            }
            funcDef.Entry = entry;
        }

        public override void Visit(MainStatBlock mainStatBlock)
        {
            this.Visit((StatBlock)mainStatBlock);
        }
            
        public override void Visit(StatBlock statBlock)
        {
            var table = new SymbolTable();

            var varDecl = statBlock.Statements.Where(stat => stat.GetType() == typeof(VarDecl)).Select(val => (VarDecl)val);

            foreach (var stat in varDecl) {
                table.Add(new TableEntry(stat.Id, Classification.Variable) {
                    Type = stat.Type + "[]".Repeat(stat.Dimensions.Count)
                }, stat.Location);
            }

            statBlock.Table = table;
        }

        public override void Visit(FParam fParam)
        {
            if (fParam.Id != string.Empty) {
                var entry = new TableEntry(fParam.Id, Classification.Parameter) {
                    Type = fParam.Type + "[]".Repeat(fParam.Dimensions.Count)
                };

                fParam.Entry = entry;
            }
        }
    }
}
