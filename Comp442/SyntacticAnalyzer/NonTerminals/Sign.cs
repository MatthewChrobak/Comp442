namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool Sign()
        {
            string first = "+ -";
            this.SkipErrors(first);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if ("+".HasToken(lookahead)) {
                this.ApplyDerivation("sign -> '+'");

                Match("+");
            }

            if ("-".HasToken(lookahead)) {
                this.ApplyDerivation("sign -> '-'");

                Match("-");
            }

            return false;
        }
    }
}
