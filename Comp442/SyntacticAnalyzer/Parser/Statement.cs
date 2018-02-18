using LexicalAnalyzer;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool Statement()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = AtoCC.Convert(lookaheadToken);

            if ("id".HasToken(lookahead)) {
                if (AssignStat() && Match(";")) {
                    return true;
                }
            }

            if ("if for get put return".HasToken(lookahead)) {
                if (NoASS()) {
                    return true;
                }
            }

            return false;
        }
    }
}
