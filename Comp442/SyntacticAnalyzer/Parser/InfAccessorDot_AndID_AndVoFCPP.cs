using LexicalAnalyzer;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool InfAccessorDot_AndID_AndVoFCPP()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = AtoCC.Convert(lookaheadToken);

            if (".".HasToken(lookahead)) {
                if (Match(".") && Match("id") && InfAccessorDot_AndID_AndVoFCP()) {
                    return true;
                }
            }

            if ("* / and + - or eq neq lt gt leq ge ] ) ; ,".HasToken(lookahead)) {
                return true;
            }

            return false;
        }
    }
}
