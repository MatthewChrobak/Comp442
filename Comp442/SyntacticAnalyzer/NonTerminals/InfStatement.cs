using LexicalAnalyzer;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool InfStatement()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = AtoCC.Convert(lookaheadToken);

            if ("id if for get put return".HasToken(lookahead)) {
                this.ApplyDerivation("infStatement -> statement infStatement");
                if (Statement() && InfStatement()) {
                    return true;
                }
            }

            if ("}".HasToken(lookahead)) {
                this.ApplyDerivation("infStatement -> EPSILON");
                return true;
            }

            return false;
        }
    }
}
