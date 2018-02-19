using LexicalAnalyzer;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool VariablePP()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = lookaheadToken.AToCC();

            if (".".HasToken(lookahead)) {
                this.ApplyDerivation("variablePP -> '.' 'id' variableP");
                if (Match(".") && Match("id") && VariableP()) {
                    return true;
                }
            }

            if ("= )".HasToken(lookahead)) {
                this.ApplyDerivation("variablePP -> EPSILON");
                return true;
            }

            return false;
        }
    }
}
