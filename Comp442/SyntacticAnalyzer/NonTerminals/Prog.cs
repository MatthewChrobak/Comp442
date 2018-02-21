using SyntacticAnalyzer.Nodes;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private Prog Prog()
        {
            string first = "program class id int float";
            this.SkipErrors(first);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();
            
            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("prog -> infClassDecl infFuncDef 'program' funcBody ';'");

                var ast = new Prog();
                //ast.Classes = InfClassDecl();
                //ast.Functions = InfFuncDef();

                InfClassDecl();
                InfFuncDef();
                Match("program");
                FuncBody();
                //ast.Program = FuncBody();

                Match(";");

                return ast;
            }

            return null;
        }
    }
}
