using LexicalAnalyzer;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool InfVarAndState()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = AtoCC.Convert(lookaheadToken);

            if ("".HasToken(lookahead)) {

            } else {
                if ("".HasToken(lookahead)) {
                    return true;
                }
            }

            return false;
        }
    }
}
