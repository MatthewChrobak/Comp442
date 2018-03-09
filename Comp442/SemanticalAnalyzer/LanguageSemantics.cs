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

            var functionLinker = new FunctionLinkerVisitor(AST.Table);
            this.AST.Accept(functionLinker);
        }
    }
}
