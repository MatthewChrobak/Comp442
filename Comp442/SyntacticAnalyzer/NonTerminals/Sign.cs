namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private string Sign()
        {
            string first = "+ -";
            this.SkipErrors(first);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if ("+".HasToken(lookahead)) {
                this.ApplyDerivation("sign -> '+'");

                return Match("+");
            }

            if ("-".HasToken(lookahead)) {
                this.ApplyDerivation("sign -> '-'");

                return Match("-");
            }

            return System.String.Empty;
        }
    }
}
