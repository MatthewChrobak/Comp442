namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool InfVarAndState()
        {
            string first = "id float int if for get put return";
            string follow = "}";
            this.SkipErrors(first, follow);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if ("id".HasToken(lookahead)) {
                this.ApplyDerivation("infVarAndState -> 'id' infVarAndState_IdHandler");

                Match("id");
                InfVarAndState_IdHandler();
            }

            if ("float int".HasToken(lookahead)) {
                this.ApplyDerivation("infVarAndState -> type_NoID 'id' infArraySize ';' infVarAndState");

                Type_NoID();
                Match("id");
                InfArraySize();
                Match(";");
                InfVarAndState();
            }

            if ("if for get put return".HasToken(lookahead)) {
                this.ApplyDerivation("infVarAndState -> noASS infStatement");

                NoASS();
                InfStatement();
            }

            if (follow.HasToken(lookahead)) {
                this.ApplyDerivation("infVarAndState -> EPSILON");
                return true;
            }

            return false;
        }
    }
}
