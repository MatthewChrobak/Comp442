using LexicalAnalyzer;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool OptSR_AndIDP()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = AtoCC.Convert(lookaheadToken);

            if ("sr".HasToken(lookahead)) {
                if (Match("sr") && Match("id")) {
                    return true;
                }
            }

            if ("(".HasToken(lookahead)) {
                return true;
            }

            return false;
        }
    }
}
