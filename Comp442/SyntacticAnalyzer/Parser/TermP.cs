using LexicalAnalyzer;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool TermP()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = AtoCC.Convert(lookaheadToken);

            if ("* / and".HasToken(lookahead)) {
                if (MultOp() && Factor() && TermP()) {
                    return true;
                }
            }

            if ("+ - or eq neq lt gt leq ge ] ) ; ,".HasToken(lookahead)) {
                return true;
            }

            return false;
        }
    }
}
