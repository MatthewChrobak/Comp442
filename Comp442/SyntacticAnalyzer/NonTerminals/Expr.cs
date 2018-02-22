namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private object Expr()
        {
            string first = "intNum floatNum ( not id + -";
            this.SkipErrors(first);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("expr -> arithExpr arithExprOrRelExpr");

                object arithExpr = ArithExpr();
                return ArithExprOrRelExpr(arithExpr);
            }

            return false;
        }
    }
}
