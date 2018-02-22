namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        // Decides between a MultOp or Factor.
        private object Term()
        {
            string first = "intNum floatNum ( not id + -";
            this.SkipErrors(first);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("term -> factor termP");

                object factor = Factor();
                return TermP(factor);
            }

            return null;
        }
    }
}
