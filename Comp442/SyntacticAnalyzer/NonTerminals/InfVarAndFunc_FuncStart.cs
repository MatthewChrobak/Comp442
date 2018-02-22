namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool InfVarAndFunc_FuncStart()
        {
            string first = "id int float";
            string follow = "}";
            this.SkipErrors(first, follow);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("infVarAndFunc_FuncStart -> type 'id' infVarAndFunc_FuncFinish");

                Type();
                Match("id");
                InfVarAndFunc_FuncFinish();
            }

            if (follow.HasToken(lookahead)) {
                this.ApplyDerivation("infVarAndFunc_FuncStart -> EPSILON");
                return true;
            }

            return false;
        }
    }
}
