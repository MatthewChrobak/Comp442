namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool InfVarAndFunc_VarFinish()
        {
            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if ("; [".HasToken(lookahead)) {
                this.ApplyDerivation("infVarAndFunc_VarFinish -> infArraySize ';' infVarAndFunc_VarStart");
                if (InfArraySize() && Match(";") && InfVarAndFunc_VarStart()) {
                    return true;
                }
            }

            if ("(".HasToken(lookahead)) {
                this.ApplyDerivation("infVarAndFunc_VarFinish -> infVarAndFunc_FuncFinish");
                if (InfVarAndFunc_FuncFinish()) {
                    return true;
                }
            }

            return false;
        }
    }
}
