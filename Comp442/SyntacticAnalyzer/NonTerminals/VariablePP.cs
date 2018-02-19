using LexicalAnalyzer;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool VariablePP()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = AtoCC.Convert(lookaheadToken);

            if (".".HasToken(lookahead)) {
                if (Match(".") && Match("id") && VariableP()) {
                    return true;
                }
            } else {
                if ("= )".HasToken(lookahead)) {
                    return true;
                }
            }

            return false;
        }
    }
}
