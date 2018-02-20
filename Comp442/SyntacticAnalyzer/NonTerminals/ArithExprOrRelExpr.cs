namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool ArithExprOrRelExpr()
        {
            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if ("eq neq lt gt leq geq".HasToken(lookahead)) {
                this.ApplyDerivation("arithExprOrRelExpr -> relOp arithExpr");
                if (RelOp() && ArithExpr()) {
                    return true;
                }
            }

            if (") ; ,".HasToken(lookahead)) {
                this.ApplyDerivation("arithExprOrRelExpr -> EPSILON");
                return true;
            }

            return false;
        }
    }
}
