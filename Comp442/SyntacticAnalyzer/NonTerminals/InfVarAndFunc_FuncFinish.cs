namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool InfVarAndFunc_FuncFinish()
        {
            string first = "(";
            this.SkipErrors(first);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("infVarAndFunc_FuncFinish -> '(' fParams ')' ';' infVarAndFunc_FuncStart");
                if (Match("(") & FParams() & Match(")") & Match(";") & InfVarAndFunc_FuncStart()) {
                    return true;
                }
            }

            return false;
        }
    }
}
