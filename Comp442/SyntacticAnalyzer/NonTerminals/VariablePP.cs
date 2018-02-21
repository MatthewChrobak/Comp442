namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool VariablePP()
        {
            string first = ".";
            string follow = "= )";
            this.SkipErrors(first, follow);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("variablePP -> '.' 'id' variableP");
                if (Match(".") & Match("id") & VariableP()) {
                    return true;
                }
            }

            if (follow.HasToken(lookahead)) {
                this.ApplyDerivation("variablePP -> EPSILON");
                return true;
            }

            return false;
        }
    }
}
