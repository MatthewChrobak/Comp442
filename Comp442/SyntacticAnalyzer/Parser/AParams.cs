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
                if (Expr() && InfAParamsTail()) {
                    return true;
                }
            } else {
                if (")".HasToken(lookahead)) {
                    return true;
                }
            }

            return false;
        }
    }
}
