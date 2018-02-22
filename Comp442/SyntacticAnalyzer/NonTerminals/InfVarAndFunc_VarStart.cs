namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool InfVarAndFunc_VarStart()
        {
            string first = "id int float";
            string follow = "}";
            this.SkipErrors(first, follow);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("infVarAndFunc_VarStart -> type 'id' infVarAndFunc_VarFinish");

                Type();
                Match("id");
                InfVarAndFunc_VarFinish();
            }

            if (follow.HasToken(lookahead)) {
                this.ApplyDerivation("infVarAndFunc_VarStart -> EPSILON");
                return true;
            }

            return false;
        }
    }
}
