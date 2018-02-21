namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool InfClassDecl()
        {
            string first = "class";
            string follow = "program id int float";
            this.SkipErrors(first, follow);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("infClassDecl -> classDecl infClassDecl");
                if (ClassDecl() & InfClassDecl()) {
                    return true;
                }
            }

            if (follow.HasToken(lookahead)) {
                this.ApplyDerivation("infClassDecl -> EPSILON");
                return true;
            }

            return false;
        }
    }
}
