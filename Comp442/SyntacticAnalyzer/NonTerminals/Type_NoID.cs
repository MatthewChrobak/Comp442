using LexicalAnalyzer;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool Type_NoID()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = AtoCC.Convert(lookaheadToken);

            if ("int".HasToken(lookahead)) {
                if (Match("int")) {
                    return true;
                }
            } else if ("float".HasToken(lookahead)) {
                if (Match("float")) {
                    return true;
                }
            }

            return false;
        }
    }
}
