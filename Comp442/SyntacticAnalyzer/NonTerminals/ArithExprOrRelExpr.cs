namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool ArithExprOrRelExpr()
        {
            string first = "eq neq lt gt leq geq";
            string follow = ") ; ,";
            this.SkipErrors(first, follow);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("arithExprOrRelExpr -> relOp arithExpr");

                RelOp();
                ArithExpr();
            }

            if (follow.HasToken(lookahead)) {
                this.ApplyDerivation("arithExprOrRelExpr -> EPSILON");
                return true;
            }

            return false;
        }
    }
}
