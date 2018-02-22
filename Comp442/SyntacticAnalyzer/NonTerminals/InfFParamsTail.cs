namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool InfFParamsTail()
        {
            string first = ",";
            string follow = ")";
            this.SkipErrors(first, follow);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("infFParamsTail -> fParamsTail infFParamsTail");

                FParamsTail();
                InfFParamsTail();
            }

            if (follow.HasToken(lookahead)) {
                this.ApplyDerivation("infFParamsTail -> EPSILON");
                return true;
            }

            return false;
        }
    }
}
