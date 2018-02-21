namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool RelExpr()
        {
            string first = "intNum floatNum ( not id + -";
            this.SkipErrors(first);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("relExpr -> arithExpr relOp arithExpr");
                if (ArithExpr() & RelOp() & ArithExpr()) {
                    return true;
                }
            }

            return false;
        }
    }
}
