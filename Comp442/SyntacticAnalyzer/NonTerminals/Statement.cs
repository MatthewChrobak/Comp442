using LexicalAnalyzer;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool Statement()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = AtoCC.Convert(lookaheadToken);

            if ("id".HasToken(lookahead)) {
                this.ApplyDerivation("statement -> assignStat ';'");
                if (AssignStat() && Match(";")) {
                    return true;
                }
            }

            if ("if for get put return".HasToken(lookahead)) {
                this.ApplyDerivation("statement -> noASS");
                if (NoASS()) {
                    return true;
                }
            }

            return false;
        }
    }
}
