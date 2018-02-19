namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool Sign()
        {
            var lookaheadToken = this._tokenStream.Peek();
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
