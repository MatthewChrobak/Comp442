namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool InfIdTrail()
        {
            string first = ",";
            string follow = "{";
            this.SkipErrors(first, follow);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("infIdTrail -> ',' 'id' infIdTrail");
                if (Match(",") & Match("id") & InfIdTrail()) {
                    return true;
                }
            }

            if (follow.HasToken(lookahead)) {
                this.ApplyDerivation("infIdTrail -> EPSILON");
                return true;
            }

            return false;
        }
    }
}
