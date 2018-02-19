using LexicalAnalyzer;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool RelOp()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = AtoCC.Convert(lookaheadToken);

            if ("eq".HasToken(lookahead)) {
                if (Match("eq")) {
                    return true;
                }
            }

            if ("neq".HasToken(lookahead)) {
                if (Match("neq")) {
                    return true;
                }
            }

            if ("lt".HasToken(lookahead)) {
                if (Match("lt")) {
                    return true;
                }
            }

            if ("gt".HasToken(lookahead)) {
                if (Match("gt")) {
                    return true;
                }
            }

            if ("leq".HasToken(lookahead)) {
                if (Match("leq")) {
                    return true;
                }
            }

            if ("geq".HasToken(lookahead)) {
                if (Match("geq")) {
                    return true;
                }
            }

            return false;
        }
    }
}
