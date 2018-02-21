namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool InfVarAndState_IdHandler()
        {
            string first = "id ( [ . =";
            this.SkipErrors(first);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if ("id".HasToken(lookahead)) {
                this.ApplyDerivation("infVarAndState_IdHandler -> 'id' infArraySize ';' infVarAndState");
                if (Match("id") & InfArraySize() & Match(";") & InfVarAndState()) {
                    return true;
                }
            }

            if ("( [ . =".HasToken(lookahead)) {
                this.ApplyDerivation("infVarAndState_IdHandler -> variableP '=' expr ';' infStatement");
                if (VariableP() & Match("=") & Expr() & Match(";") & InfStatement()) {
                    return true;
                }
            }

            return false;
        }
    }
}
