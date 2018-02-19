using LexicalAnalyzer;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool VariableP()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = AtoCC.Convert(lookaheadToken);

            if ("(".HasToken(lookahead)) {
                if (Match("(") && AParams() && Match(")") && Match(".") && Match("id") && VariableP()) {
                    return true;
                }
            } else if ("[ .".HasToken(lookahead)) {
                if (InfIndice() && VariablePP()) {
                    return true;
                }
            }

            if ("= )".HasToken(lookahead)) {
                return true;
            }

            return false;
        }
    }
}
