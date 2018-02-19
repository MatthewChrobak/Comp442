using LexicalAnalyzer;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool ArithExprP()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = AtoCC.Convert(lookaheadToken);

            if ("+ - or".HasToken(lookahead)) {
                if (AddOp() && Term() && ArithExprP()) {
                    return true;
                }
            }

            if ("eq neq lt gt leq ge ] ) ; ,".HasToken(lookahead)) {
                return true;
            }

            return false;
        }
    }
}
