using LexicalAnalyzer;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool FParams()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = AtoCC.Convert(lookaheadToken);

            if ("id int float".HasToken(lookahead)) {
                this.ApplyDerivation("fParams -> type 'id' infArraySize infFParamsTail");
                if (Type() && Match("id") && InfArraySize() && InfFParamsTail()) {
                    return true;
                }
            }

            if (")".HasToken(lookahead)) {
                this.ApplyDerivation("fParams -> EPSILON");
                return true;
            }

            return false;
        }
    }
}
