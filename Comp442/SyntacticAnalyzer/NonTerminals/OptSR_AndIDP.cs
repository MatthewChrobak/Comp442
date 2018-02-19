using LexicalAnalyzer;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool OptSR_AndIDP()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = lookaheadToken.AToCC();

            if ("sr".HasToken(lookahead)) {
                this.ApplyDerivation("optSR_AndIDP -> 'sr' 'id'");
                if (Match("sr") && Match("id")) {
                    return true;
                }
            }

            if ("(".HasToken(lookahead)) {
                this.ApplyDerivation("optSR_AndIDP -> EPSILON");
                return true;
            }

            return false;
        }
    }
}
