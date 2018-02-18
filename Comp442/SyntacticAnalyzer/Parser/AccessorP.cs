using LexicalAnalyzer;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool AccessorP()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = AtoCC.Convert(lookaheadToken);

            if ("(".HasToken(lookahead)) {
                if (Match("(") && AParams() && Match(")")) {
                    return true;
                }
            }

            if ("[".HasToken(lookahead)) {
                if (InfIndice()) {
                    return true;
                }
            }

            if (". * / and + - or eq neq lt gt leq ge ] ) ; ,".HasToken(lookahead)) {
                return true;
            }

            return false;
        }
    }
}
