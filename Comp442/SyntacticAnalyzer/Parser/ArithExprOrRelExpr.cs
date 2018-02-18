using LexicalAnalyzer;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool ArithExprOrRelExpr()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = AtoCC.Convert(lookaheadToken);

            if ("eq neq lt gt leq geq".HasToken(lookahead)) {
                if (RelOp() && ArithExpr()) {
                    return true;
                }
            }

            if (") ; ,".HasToken(lookahead)) {
                return true;
            }

            return false;
        }
    }
}
