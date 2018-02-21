namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool AParamsTail()
        {
            string first = ",";
            this.SkipErrors(first);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("aParamsTail -> ',' expr");
                if (Match(",") & Expr()) {
                    return true;
                }
            }

            return false;
        }
    }
}
