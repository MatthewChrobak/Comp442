namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool Variable()
        {
            string first = "id";
            this.SkipErrors(first);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("variable -> 'id' variableP");

                Match("id");
                VariableP();
            }

            return false;
        }
    }
}
