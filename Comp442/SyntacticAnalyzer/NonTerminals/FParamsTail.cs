namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool FParamsTail()
        {
            string first = ",";
            this.SkipErrors(first);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("fParamsTail -> ',' type 'id' infArraySize");

                Match(",");
                Type();
                Match("id");
                InfArraySize();
            }

            return false;
        }
    }
}
