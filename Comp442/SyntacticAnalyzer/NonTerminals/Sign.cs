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
                if (Match("+")) {
                    return true;
                }
            }

            if ("-".HasToken(lookahead)) {
                this.ApplyDerivation("sign -> '-'");
                if (Match("-")) {
                    return true;
                }
            }

            return false;
        }
    }
}
