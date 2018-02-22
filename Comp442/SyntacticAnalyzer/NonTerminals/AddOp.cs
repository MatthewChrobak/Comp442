namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool AddOp()
        {
            string first = "+ - or";
            this.SkipErrors(first);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if ("+".HasToken(lookahead)) {
                this.ApplyDerivation("addOp -> '+'");

                Match("+");
            }

            if ("-".HasToken(lookahead)) {
                this.ApplyDerivation("addOp -> '-'");

                Match("-");
            }

            if ("or".HasToken(lookahead)) {
                this.ApplyDerivation("addOp -> 'or'");

                Match("or");
            }

            return false;
        }
    }
}
