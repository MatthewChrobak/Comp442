namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool InfVarAndFunc_FuncFinish()
        {
            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if ("(".HasToken(lookahead)) {
                this.ApplyDerivation("infVarAndFunc_FuncFinish -> '(' fParams ')' ';' infVarAndFunc_FuncStart");
                if (Match("(") && FParams() && Match(")") && Match(";") && InfVarAndFunc_FuncStart()) {
                    return true;
                }
            }

            return false;
        }
    }
}
