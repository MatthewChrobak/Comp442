using LexicalAnalyzer;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool InfAccessorDot_AndID_AndVoFCP()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = AtoCC.Convert(lookaheadToken);

            if ("[ (".HasToken(lookahead)) {
                if (AccessorP() && InfAccessorDot_AndID_AndVoFCPP()) {
                    return true;
                }
            }

            if ("* / and + - or eq neq lt gt leq geq ] ) ; ,".HasToken(lookahead)) {
                return true;
            }

            return false;
        }
    }
}
