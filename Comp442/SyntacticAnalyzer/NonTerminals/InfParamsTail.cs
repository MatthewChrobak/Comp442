using LexicalAnalyzer;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool InfFParamsTail()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = AtoCC.Convert(lookaheadToken);

            if (",".HasToken(lookahead)) {
                if (FParamsTail()) {
                    return true;
                }
            } else {
                if (")".HasToken(lookahead)) {
                    return true;
                }
            }

            return false;
        }
    }
}
