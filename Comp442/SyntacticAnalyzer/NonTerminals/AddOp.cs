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
                if (Match("+")) {
                    return true;
                }
            }

            if ("-".HasToken(lookahead)) {
                this.ApplyDerivation("addOp -> '-'");
                if (Match("-")) {
                    return true;
                }
            }

            if ("or".HasToken(lookahead)) {
                this.ApplyDerivation("addOp -> 'or'");
                if (Match("or")) {
                    return true;
                }
            }

            return false;
        }
    }
}
