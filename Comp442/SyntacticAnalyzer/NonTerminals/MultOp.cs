namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private string MultOp()
        {
            string first = "* / and";
            this.SkipErrors(first);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if ("*".HasToken(lookahead)) {
                this.ApplyDerivation("multOp -> '*'");

                return Match("*");
            }

            if ("/".HasToken(lookahead)) {
                this.ApplyDerivation("multOp -> '/'");

                return Match("/");
            }

            if ("and".HasToken(lookahead)) {
                this.ApplyDerivation("multOp -> 'and'");

                return Match("and");
            }

            return System.String.Empty;
        }
    }
}