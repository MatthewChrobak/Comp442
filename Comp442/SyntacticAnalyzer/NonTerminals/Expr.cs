namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool Expr()
        {
            string first = "intNum floatNum ( not id + -";
            this.SkipErrors(first);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("expr -> arithExpr arithExprOrRelExpr");
                if (ArithExpr() & ArithExprOrRelExpr()) {
                    return true;
                }
            }

            return false;
        }
    }
}
