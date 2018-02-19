using LexicalAnalyzer;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool StatBlock()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = AtoCC.Convert(lookaheadToken);

            if ("{".HasToken(lookahead)) {
                if (Match("{") && InfStatement() && Match("}")) {
                    return true;
                }
            }

            if ("id if for get put return".HasToken(lookahead)) {
                if (Statement()) {
                    return true;
                }
            }

            if ("else ;".HasToken(lookahead)) {
                return true;
            }

            return false;
        }
    }
}
