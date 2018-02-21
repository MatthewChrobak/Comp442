namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool InfStatement()
        {
            string first = "id if for get put return";
            string follow = "}";
            this.SkipErrors(first, follow);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("infStatement -> statement infStatement");
                if (Statement() & InfStatement()) {
                    return true;
                }
            }

            if (follow.HasToken(lookahead)) {
                this.ApplyDerivation("infStatement -> EPSILON");
                return true;
            }

            return false;
        }
    }
}
