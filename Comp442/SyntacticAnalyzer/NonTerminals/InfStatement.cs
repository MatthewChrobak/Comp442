using LexicalAnalyzer;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool InfStatement()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = AtoCC.Convert(lookaheadToken);

            if ("id if for get put return".HasToken(lookahead)) {
                if (Statement() && InfStatement()) {
                    return true;
                }
            }

            if ("}".HasToken(lookahead)) {
                return true;
            }

            return false;
        }
    }
}
