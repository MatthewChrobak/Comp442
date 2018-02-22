using SyntacticAnalyzer.Nodes;
using System.Collections.Generic;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private List<object> InfVarAndFunc_VarStart()
        {
            string first = "id int float";
            string follow = "}";
            this.SkipErrors(first, follow);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("infVarAndFunc_VarStart -> type 'id' infVarAndFunc_VarFinish");

                var memberList = new List<object>();

                string type = Type();
                string id = Match("id");
                var fullVarAndFuncList = InfVarAndFunc_VarFinish(type, id);
                
                memberList.JoinListWhereNotNull(fullVarAndFuncList);

                return memberList;
            }

            if (follow.HasToken(lookahead)) {
                this.ApplyDerivation("infVarAndFunc_VarStart -> EPSILON");
                return new List<object>();
            }

            return null;
        }
    }
}
