namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool ArithExprP()
        {
            string first = "+ - or";
            string follow = "eq neq lt gt leq geq ] ) ; ,";
            this.SkipErrors(first, follow);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("arithExprP -> addOp term arithExprP");

                AddOp();
                Term();
                ArithExprP();
            }

            if (follow.HasToken(lookahead)) {
                this.ApplyDerivation("arithExprP -> EPSILON");
                return true;
            }

            return false;
        }
    }
}
