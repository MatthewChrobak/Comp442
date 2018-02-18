using LexicalAnalyzer;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        public bool Type()
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

        public bool Type_NoID()
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
