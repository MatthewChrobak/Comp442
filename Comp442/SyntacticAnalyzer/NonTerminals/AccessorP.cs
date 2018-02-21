namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool AccessorP()
        {
            string first = "( [";
            string follow = ". * / and + - or eq neq lt gt leq geq ] ) ; ,";
            this.SkipErrors(first, follow);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if ("(".HasToken(lookahead)) {
                this.ApplyDerivation("accessorP -> '(' aParams ')'");
                if (Match("(") & AParams() & Match(")")) {
                    return true;
                }
            }

            if ("[".HasToken(lookahead)) {
                this.ApplyDerivation("accessorP -> infIndice");
                if (InfIndice()) {
                    return true;
                }
            }

            if (follow.HasToken(lookahead)) {
                this.ApplyDerivation("accessorP -> infIndice");
                this.ApplyDerivation("infIndice -> EPSILON");
                return true;
            }

            return false;
        }
    }
}
