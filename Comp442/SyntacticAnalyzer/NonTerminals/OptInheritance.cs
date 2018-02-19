using LexicalAnalyzer;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool OptInheritance()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = lookaheadToken.AToCC();

            if (":".HasToken(lookahead)) {
                this.ApplyDerivation("optInheritance -> ':' 'id' infIdTrail");
                if (Match(":") && Match("id") && InfIdTrail()) {
                    return true;
                }
            }

            if ("{".HasToken(lookahead)) {
                this.ApplyDerivation("optInheritance -> EPSILON");
                return true;
            }

            return false;
        }
    }
}
