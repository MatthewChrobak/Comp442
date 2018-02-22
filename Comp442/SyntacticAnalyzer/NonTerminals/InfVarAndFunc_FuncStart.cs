using System.Collections.Generic;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private List<object> InfVarAndFunc_FuncStart()
        {
            string first = "id int float";
            string follow = "}";
            this.SkipErrors(first, follow);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("infVarAndFunc_FuncStart -> type 'id' infVarAndFunc_FuncFinish");

                string type = Type();
                string id = Match("id");
                return InfVarAndFunc_FuncFinish(type, id);
            }

            if (follow.HasToken(lookahead)) {
                this.ApplyDerivation("infVarAndFunc_FuncStart -> EPSILON");
                return new List<object>();
            }

            return null;
        }
    }
}
