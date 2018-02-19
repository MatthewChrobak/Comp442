using LexicalAnalyzer;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool InfAccessorDot_AndID_AndVoFCPP()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = lookaheadToken.AToCC();

            if (".".HasToken(lookahead)) {
                this.ApplyDerivation("infAccessorDot_AndID_AndVoFCPP -> '.' 'id' infAccessorDot_AndID_AndVoFCP");
                if (Match(".") && Match("id") && InfAccessorDot_AndID_AndVoFCP()) {
                    return true;
                }
            }

            if ("* / and + - or eq neq lt gt leq ge ] ) ; ,".HasToken(lookahead)) {
                this.ApplyDerivation("infAccessorDot_AndID_AndVoFCPP -> EPSILON");
                return true;
            }

            return false;
        }
    }
}
