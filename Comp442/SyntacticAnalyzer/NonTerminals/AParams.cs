namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool AParams()
        {
            string first = "intNum floatNum ( not id + -";
            string follow = ")";
            this.SkipErrors(first, follow);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("aParams -> expr infAParamsTail");
                if (Expr() & InfAParamsTail()) {
                    return true;
                }
            }

            if (follow.HasToken(lookahead)) {
                this.ApplyDerivation("aParams -> EPSILON");
                return true;
            }

            return false;
        }
    }
}
