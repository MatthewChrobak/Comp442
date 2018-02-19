using LexicalAnalyzer;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool InfAParamsTail()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = AtoCC.Convert(lookaheadToken);

            if (",".HasToken(lookahead)) {
                if (AParamsTail() && InfAParamsTail()) {
                    return true;
                }
            }

            if (")".HasToken(lookahead)) {
                return true;
            }

            return false;
        }
    }
}
