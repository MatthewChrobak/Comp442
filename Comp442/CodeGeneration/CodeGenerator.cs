using CodeGeneration.Visitors;
using Errors;
using SyntacticAnalyzer.Nodes;

namespace CodeGeneration
{
    public partial class CodeGenerator
    {
        private Program AST;

        public void Generate(Program ast)
        {
            if (ast == null) {
                ErrorManager.Add("Code Generation: Could not find the main program.", (0, 0));
                return;
            }

            this.AST = ast;

            // Generate the code.
            var memVisitor = new MemorySizeVisitor(this.AST.Table);
            ast.Accept(memVisitor);

            var stackVisitor = new StackIncreaserVisitor(this.AST.Table, memVisitor.Sizes);
            ast.Accept(stackVisitor);

            var moonVisitor = new MoonVisitor(this.AST.Table);
            ast.Accept(moonVisitor);
        }
    }
}
