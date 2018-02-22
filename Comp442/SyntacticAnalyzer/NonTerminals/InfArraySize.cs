namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool InfArraySize()
        {
            string first = "[";
            string follow = ", ; )";
            this.SkipErrors(first, follow);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("infArraySize -> arraySize infArraySize");

                ArraySize();
                InfArraySize();
            }

            if (follow.HasToken(lookahead)) {
                this.ApplyDerivation("infArraySize -> EPSILON");
                return true;
            }

            return false;
        }
    }
}
