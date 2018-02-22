namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool Indice()
        {
            string first = "[";
            this.SkipErrors(first);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("indice -> '[' arithExpr ']'");

                Match("[");
                ArithExpr();
                Match("]");
            }
           

            return false;
        }
    }
}
