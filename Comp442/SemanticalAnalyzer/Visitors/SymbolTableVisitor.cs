using SyntacticAnalyzer.Nodes;
using SyntacticAnalyzer.Semantics;

namespace SemanticalAnalyzer.Visitors
{
    public class SymbolTableVisitor : Visitor
    {
        public override void Visit(Program node)
        {
            var globalTable = new SymbolTable();

            foreach (var @class in node.Classes?.Classes) {
                globalTable.Add(new TableEntry(@class.ClassName, TableEntryType.Class) {
                    Link = @class.Table
                });
            }

            foreach (var func in node.Functions?.Functions) {
                globalTable.Add(new TableEntry(func.FunctionName, TableEntryType.Function) {
                    Link = func.Table
                });
            }

            node.Table = globalTable;
        }

        #region Class
        public override void Visit(ClassDecl classDecl)
        {
            var classTable = new SymbolTable();

            foreach (var entry in classDecl.Members) {
                if (entry as VarDecl != null) {
                    var variable = entry as VarDecl;
                    classTable.Add(new TableEntry(variable.Id, TableEntryType.Variable) {
                        Link = variable.Table
                    });
                    continue;
                }
                if (entry as FuncDecl != null) {
                    var func = entry as FuncDecl;
                    classTable.Add(new TableEntry(func.Id, TableEntryType.Function) {
                        Link = func.Table
                    });
                    continue;
                }
                throw new System.Exception();
            }

            classDecl.Table = classTable;
        }
        #endregion

        #region Members
        public override void Visit(FuncDecl funcDecl)
        {
            var functionTabl = new SymbolTable();

            funcDecl.Table = functionTabl;
        }

        public override void Visit(VarDecl var)
        {
            var variableEntry = new SymbolTable();

            var.Table = variableEntry;
        }
        #endregion

        #region Functions
        public override void Visit(FuncDef funcDef)
        {
            
        }
        #endregion
    }
}
