using Errors;
using SemanticalAnalyzer.Visitors;
using SyntacticAnalyzer.Nodes;

namespace SemanticalAnalyzer
{
    public partial class LanguageSemantics
    {
        private Program AST;

        public void Apply(Program node)
        {
            this.AST = node;

            if (this.AST == null) {
                ErrorManager.Add(new Error("Could not find the main program.", (0, 0)));
                this.AST = new Program((0, 0));
                this.AST.Classes = new ClassList((0, 0));
                this.AST.Functions = new FuncDefList((0, 0));
                this.AST.MainFunction = new MainStatBlock(null);
                this.AST.Table = new SyntacticAnalyzer.Semantics.SymbolTable();
                return;
            }

            // Generate the symbol tables.
            var symbolTableVisitor = new SymbolTableVisitor();
            this.AST.Accept(symbolTableVisitor);

            var functionLinker = new FunctionLinkerVisitor(this.AST.Table);
            this.AST.Accept(functionLinker);

            var classInheriter = new InheritanceVisitor(this.AST.Table);
            this.AST.Accept(classInheriter);

            var typeVisitor = new TypeVisitor(this.AST.Table);
            this.AST.Accept(typeVisitor);
        }
    }
}
