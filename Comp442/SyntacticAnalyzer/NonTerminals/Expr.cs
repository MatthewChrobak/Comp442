namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool Expr()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if ("intNum floatNum ( not id + -".HasToken(lookahead)) {
                this.ApplyDerivation("expr -> arithExpr arithExprOrRelExpr");
                if (ArithExpr() && ArithExprOrRelExpr()) {
                    return true;
                }
            }

            return false;
        }
    }
}
