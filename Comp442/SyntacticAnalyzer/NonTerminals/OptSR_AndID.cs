namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool OptSR_AndID()
        {
            string first = "id";
            this.SkipErrors(first);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("optSR_AndID -> 'id' optSR_AndIDP");
                if (Match("id") & OptSR_AndIDP()) {
                    return true;
                }
            }

            return false;
        }
    }
}
