namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private string AddOp()
        {
            string first = "+ - or";
            this.SkipErrors(first);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if ("+".HasToken(lookahead)) {
                this.ApplyDerivation("addOp -> '+'");

                return Match("+");
            }

            if ("-".HasToken(lookahead)) {
                this.ApplyDerivation("addOp -> '-'");

                return Match("-");
            }

            if ("or".HasToken(lookahead)) {
                this.ApplyDerivation("addOp -> 'or'");

                return Match("or");
            }

            return System.String.Empty;
        }
    }
}
