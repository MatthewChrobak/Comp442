namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool InfClassDecl()
        {
            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if ("class".HasToken(lookahead)) {
                this.ApplyDerivation("infClassDecl -> classDecl infClassDecl");
                if (ClassDecl() && InfClassDecl()) {
                    return true;
                }
            }

            if ("program id int float".HasToken(lookahead)) {
                this.ApplyDerivation("infClassDecl -> EPSILON");
                return true;
            }

            return false;
        }
    }
}
