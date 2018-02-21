namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool Term()
        {
            string first = "intNum floatNum ( not id + -";
            this.SkipErrors(first);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("term -> factor termP");
                if (Factor() & TermP()) {
                    return true;
                }
            }

            return false;
        }
    }
}
