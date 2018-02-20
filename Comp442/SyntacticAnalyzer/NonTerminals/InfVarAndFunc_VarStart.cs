namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool InfVarAndFunc_VarStart()
        {
            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if ("id int float".HasToken(lookahead)) {
                this.ApplyDerivation("infVarAndFunc_VarStart -> type 'id' infVarAndFunc_VarFinish");
                if (Type() && Match("id") && InfVarAndFunc_VarFinish()) {
                    return true;
                }
            }

            if ("}".HasToken(lookahead)) {
                this.ApplyDerivation("infVarAndFunc_VarStart -> EPSILON");
                return true;
            }

            return false;
        }
    }
}
