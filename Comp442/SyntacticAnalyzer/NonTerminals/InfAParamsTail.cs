using LexicalAnalyzer;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool InfAParamsTail()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = lookaheadToken.AToCC();

            if (",".HasToken(lookahead)) {
                this.ApplyDerivation("infAParamsTail -> aParamsTail infAParamsTail");
                if (AParamsTail() && InfAParamsTail()) {
                    return true;
                }
            }

            if (")".HasToken(lookahead)) {
                this.ApplyDerivation("infAParamsTail -> EPSILON");
                return true;
            }

            return false;
        }
    }
}
