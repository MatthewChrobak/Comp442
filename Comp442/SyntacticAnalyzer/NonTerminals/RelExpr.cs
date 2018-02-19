namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool RelExpr()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if ("intNum floatNum ( not id + -".HasToken(lookahead)) {
                this.ApplyDerivation("relExpr -> arithExpr relOp arithExpr");
                if (ArithExpr() && RelOp() && ArithExpr()) {
                    return true;
                }
            }

            return false;
        }
    }
}
