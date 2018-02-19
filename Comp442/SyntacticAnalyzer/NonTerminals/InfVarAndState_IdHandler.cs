using LexicalAnalyzer;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool InfVarAndState_IdHandler()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = lookaheadToken.AToCC();

            if ("id".HasToken(lookahead)) {
                this.ApplyDerivation("infVarAndState_IdHandler -> 'id' infArraySize ';' infVarAndState");
                if (Match("id") && InfArraySize() && Match(";") && InfVarAndState()) {
                    return true;
                }
            }

            if ("( [ . =".HasToken(lookahead)) {
                this.ApplyDerivation("infVarAndState_IdHandler -> variableP '=' expr ';' infStatement");
                if (VariableP() && Match("=") && Expr() && Match(";") && InfStatement()) {
                    return true;
                }
            }

            return false;
        }
    }
}
