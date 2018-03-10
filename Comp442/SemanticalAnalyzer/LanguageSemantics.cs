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

            // Generate the symbol tables.
            var symbolTableVisitor = new SymbolTableVisitor();
            this.AST.Accept(symbolTableVisitor);

            var functionLinker = new FunctionLinkerVisitor(this.AST.Table);
            this.AST.Accept(functionLinker);

            var classInheriter = new InheritanceVisitor(this.AST.Table);
            this.AST.Accept(classInheriter);
        }
    }
}
