using LexicalAnalyzer;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool AddOp()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = lookaheadToken.AToCC();

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
