namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool VariablePP()
        {
            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (".".HasToken(lookahead)) {
                this.ApplyDerivation("variablePP -> '.' 'id' variableP");
                if (Match(".") && Match("id") && VariableP()) {
                    return true;
                }
            }

            if ("= )".HasToken(lookahead)) {
                this.ApplyDerivation("variablePP -> EPSILON");
                return true;
            }

            return false;
        }
    }
}
