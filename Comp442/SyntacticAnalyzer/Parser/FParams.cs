using LexicalAnalyzer;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        public bool FParams()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = AtoCC.Convert(lookaheadToken);

            if ("id int float".HasToken(lookahead)) {
                if (Type() && Match("id") && InfArraySize() && InfFParamsTail()) {
                    return true;
                }
            } else {
                if (")".HasToken(lookahead)) {
                    return true;
                }
            }

            return false;
        }

        public bool InfFParamsTail()
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

        public bool FParamsTail()
        {
            if (Match(",") && Type() && Match("id") && InfArraySize()) {
                return true;
            }

            return false;
        }
    }
}
