namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool OptSR_AndIDP()
        {
            string first = "sr";
            string follow = "(";
            this.SkipErrors(first, follow);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("optSR_AndIDP -> 'sr' 'id'");

                Match("sr");
                Match("id");
            }

            if (follow.HasToken(lookahead)) {
                this.ApplyDerivation("optSR_AndIDP -> EPSILON");
                return true;
            }

            return false;
        }
    }
}
