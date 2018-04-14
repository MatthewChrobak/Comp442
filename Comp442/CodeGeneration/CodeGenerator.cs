using CodeGeneration.Visitors;
using Errors;
using SyntacticAnalyzer.Nodes;
using SyntacticAnalyzer.Semantics;

namespace CodeGeneration
{
    public partial class CodeGenerator
    {
        private SymbolTable Table;

        public void Generate(Program ast)
        {
            if (ast == null) {
                ErrorManager.Add("Code Generation: Could not find the main program.", (0, 0));
                return;
            }

            this.Table = ast.Table.Copy();

            // Generate the code.
            var memVisitor = new MemorySizeVisitor(this.Table);
            ast.Accept(memVisitor);

            var stackVisitor = new StackIncreaserVisitor(this.Table);
            ast.Accept(stackVisitor);

            var moonVisitor = new MoonVisitor(this.Table);
            ast.Accept(moonVisitor);
        }
    }
}
