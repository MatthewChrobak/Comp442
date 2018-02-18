using LexicalAnalyzer;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool InfArraySize()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = AtoCC.Convert(lookaheadToken);

            if ("[".HasToken(lookahead)) {
                if (ArraySize() && InfArraySize()) {
                    return true;
                }
            } else {
                if (", ; )".HasToken(lookahead)) {
                    return true;
                }
            }

            return false;
        }
    }
}
