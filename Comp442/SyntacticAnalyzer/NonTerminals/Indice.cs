namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private object Indice()
        {
            string first = "[";
            this.SkipErrors(first);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("indice -> '[' arithExpr ']'");

                Match("[");
                object expr = ArithExpr();
                Match("]");

                return expr;
            }
           

            return null;
        }
    }
}
