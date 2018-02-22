namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool MultOp()
        {
            string first = "* / and";
            this.SkipErrors(first);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if ("*".HasToken(lookahead)) {
                this.ApplyDerivation("multOp -> '*'");

                Match("*");
            }

            if ("/".HasToken(lookahead)) {
                this.ApplyDerivation("multOp -> '/'");

                Match("/");
            }

            if ("and".HasToken(lookahead)) {
                this.ApplyDerivation("multOp -> 'and'");

                Match("and");
            }

            return false;
        }
    }
}