using LexicalAnalyzer;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool AParams()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = AtoCC.Convert(lookaheadToken);

            if ("intNum floatNum ( not id + -".HasToken(lookahead)) {
                this.ApplyDerivation("aParams -> expr infAParamsTail");
                if (Expr() && InfAParamsTail()) {
                    return true;
                }
            }

            if (")".HasToken(lookahead)) {
                this.ApplyDerivation("aParams -> EPSILON");
                return true;
            }

            return false;
        }
    }
}
