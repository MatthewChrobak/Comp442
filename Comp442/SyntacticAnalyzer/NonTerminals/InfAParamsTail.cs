namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool InfAParamsTail()
        {
            string first = ",";
            string follow = ")";
            this.SkipErrors(first, follow);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("infAParamsTail -> aParamsTail infAParamsTail");
                if (AParamsTail() & InfAParamsTail()) {
                    return true;
                }
            }

            if (follow.HasToken(lookahead)) {
                this.ApplyDerivation("infAParamsTail -> EPSILON");
                return true;
            }

            return false;
        }
    }
}
