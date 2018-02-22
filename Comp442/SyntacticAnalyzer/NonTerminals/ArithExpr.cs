namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private object ArithExpr()
        {
            string first = "intNum floatNum ( not id + -";
            this.SkipErrors(first);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("arithExpr -> term arithExprP");

                object term = Term();
                return ArithExprP(term);
            }

            return null;
        }
    }
}
