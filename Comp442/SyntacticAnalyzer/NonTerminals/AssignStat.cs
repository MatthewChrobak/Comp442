namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool AssignStat()
        {
            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if ("id".HasToken(lookahead)) {
                this.ApplyDerivation("assignStat -> variable '=' expr");
                if (Variable() && Match("=") && Expr()) {
                    return true;
                }
            }

            return false;
        }
    }
}
