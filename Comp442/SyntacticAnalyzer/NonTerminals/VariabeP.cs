namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool VariableP()
        {
            string first = "( [ .";
            string follow = "= )";
            this.SkipErrors(first, follow);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if ("(".HasToken(lookahead)) {
                this.ApplyDerivation("variableP -> '(' aParams ')' '.' 'id' variableP");

                Match("(");
                AParams();
                Match(")");
                Match(".");
                Match("id");
                VariableP();
            }

            if ("[ .".HasToken(lookahead)) {
                this.ApplyDerivation("variableP -> infIndice variablePP");
                if (InfIndice() & VariablePP()) {
                    return true;
                }
            }

            if (follow.HasToken(lookahead)) {
                this.ApplyDerivation("variableP -> infIndice variablePP");
                this.ApplyDerivation("infIndice -> EPSILON");
                this.ApplyDerivation("variablePP -> EPSILON");
                return true;
            }

            return false;
        }
    }
}
