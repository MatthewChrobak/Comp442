namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool Variable()
        {
            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if ("id".HasToken(lookahead)) {
                this.ApplyDerivation("variable -> 'id' variableP");
                if (Match("id") && VariableP()) {
                    return true;
                }
            }

            return false;
        }
    }
}
