using SyntacticAnalyzer.Nodes;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private Program Prog()
        {
            string first = "program class id int float";
            this.SkipErrors(first);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();
            
            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("prog -> infClassDecl infFuncDef 'program' funcBody ';'");

                var ast = new Program();
                ast.Classes = InfClassDecl();
                ast.Functions = InfFuncDef();
                Match("program");
                ast.MainFunction = FuncBody();

                Match(";");

                return ast;
            }

            return null;
        }
    }
}
