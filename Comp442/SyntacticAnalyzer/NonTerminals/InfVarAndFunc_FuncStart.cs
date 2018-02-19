namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool InfVarAndFunc_FuncStart()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if ("id int float".HasToken(lookahead)) {
                this.ApplyDerivation("infVarAndFunc_FuncStart -> type 'id' infVarAndFunc_FuncFinish");
                if (Type() && Match("id") && InfVarAndFunc_FuncFinish()) {
                    return true;
                }
            }

            if ("}".HasToken(lookahead)) {
                this.ApplyDerivation("infVarAndFunc_FuncStart -> EPSILON");
                return true;
            }

            return false;
        }
    }
}
