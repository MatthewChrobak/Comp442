using LexicalAnalyzer;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool InfIdTrail()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = lookaheadToken.AToCC();

            if (",".HasToken(lookahead)) {
                this.ApplyDerivation("infIdTrail -> ',' 'id' infIdTrail");
                if (Match(",") && Match("id") && InfIdTrail()) {
                    return true;
                }
            }

            if ("{".HasToken(lookahead)) {
                this.ApplyDerivation("infIdTrail -> EPSILON");
                return true;
            }

            return false;
        }
    }
}
