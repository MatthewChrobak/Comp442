using LexicalAnalyzer;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool Type()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = AtoCC.Convert(lookaheadToken);

            if ("id".HasToken(lookahead)) {
                if (Match("id")) {
                    return true;
                }
            } else if ("int float".HasToken(lookahead)) {
                if (Type_NoID()) {
                    return true;
                }
            }

            return false;
        }
    }
}
