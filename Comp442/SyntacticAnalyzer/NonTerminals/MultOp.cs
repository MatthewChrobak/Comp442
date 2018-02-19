using LexicalAnalyzer;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool MultOp()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = AtoCC.Convert(lookaheadToken);

            if ("*".HasToken(lookahead)) {
                if (Match("*")) {
                    return true;
                }
            }

            if ("/".HasToken(lookahead)) {
                if (Match("/")) {
                    return true;
                }
            }

            if ("and".HasToken(lookahead)) {
                if (Match("and")) {
                    return true;
                }
            }

            return false;
        }
    }
}