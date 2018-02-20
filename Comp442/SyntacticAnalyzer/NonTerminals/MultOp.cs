namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool MultOp()
        {
            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if ("*".HasToken(lookahead)) {
                this.ApplyDerivation("multOp -> '*'");
                if (Match("*")) {
                    return true;
                }
            }

            if ("/".HasToken(lookahead)) {
                this.ApplyDerivation("multOp -> '/'");
                if (Match("/")) {
                    return true;
                }
            }

            if ("and".HasToken(lookahead)) {
                this.ApplyDerivation("multOp -> 'and'");
                if (Match("and")) {
                    return true;
                }
            }

            return false;
        }
    }
}