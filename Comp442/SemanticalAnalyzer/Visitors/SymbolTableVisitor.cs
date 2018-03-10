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

            foreach (var @class in node.Classes?.Classes) {
                this.GlobalScope.Add(new TableEntry(@class.ClassName, Classification.Class) {
                    Link = @class.Table
                });
            }

            foreach (var func in node.Functions?.Functions) {
                this.GlobalScope.Add(func.Entry);
            }

            this.GlobalScope.Add(new TableEntry("main", Classification.Function) {
                Link = node.MainFunction.Table
            });

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
                        Type = variable.Type
                    });
                    continue;
                }
                if (entry as FuncDecl != null) {
                    var func = entry as FuncDecl;
                    classTable.Add(new TableEntry(func.Id, Classification.Function) {
                        Link = func.Table,
                        Type = func.Type + "-" + string.Join(",", func.Parameters.Select(val => val.Type + string.Join(string.Empty, val.Dimensions.Select(dim => "[]"))))
                    });
                    continue;
                }
                throw new System.Exception();
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

            foreach (var param in funcDef.Parameters) {
                entry.Link.Add(param.Entry);
            }

            foreach (var varEntry in funcDef.Implementation.Table.GetAll()) {
                entry.Link.Add(varEntry);
            }

            entry.Type = funcDef.ReturnType + "-" + string.Join(",", funcDef.Parameters.Select(val => val.Type + string.Join(string.Empty, val.Dimensions.Select(dim => "[]"))));

            funcDef.Entry = entry;
        }

        public override void Visit(StatBlock statBlock)
        {
            var table = new SymbolTable();

            var varDecl = statBlock.Statements.Where(stat => stat.GetType() == typeof(VarDecl)).Select(val => (VarDecl)val);

            foreach (var stat in varDecl) {
                table.Add(new TableEntry(stat.Id, Classification.Variable) {
                    Type = stat.Type
                });
            }

            statBlock.Table = table;
        }

        public override void Visit(FParam fParam)
        {
            var entry = new TableEntry(fParam.Id, Classification.Parameter) {
                Type = fParam.Type
            };
            fParam.Entry = entry;
        }
    }
}
