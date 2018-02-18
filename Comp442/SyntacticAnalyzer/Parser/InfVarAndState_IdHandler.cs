using LexicalAnalyzer;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool InfVarAndState_IdHandler()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = AtoCC.Convert(lookaheadToken);

            if ("id".HasToken(lookahead)) {
                if (Match("id") && InfArraySize() && Match(";") && InfVarAndState()) {
                    return true;
                }
            } else if ("( [ . =".HasToken(lookahead)) {
                if (VariableP() && AssignOp() && Expr() && Match(";") && InfStatement()) {
                    return true;
                }
            }

            return false;
        }
    }
}
