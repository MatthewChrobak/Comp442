using SyntacticAnalyzer.Nodes;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private MembList InfVarAndFunc_VarStart()
        {
            string first = "id int float";
            string follow = "}";
            this.SkipErrors(first, follow);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("infVarAndFunc_VarStart -> type 'id' infVarAndFunc_VarFinish");

                var memberList = new MembList();

                string type = Type();
                string id = Match("id");
                var fullVarAndFuncList = InfVarAndFunc_VarFinish(type, id);
                
                memberList.Members.JoinListWhereNotNull(fullVarAndFuncList?.Members);

                return memberList;
            }

            if (follow.HasToken(lookahead)) {
                this.ApplyDerivation("infVarAndFunc_VarStart -> EPSILON");
                return new MembList();
            }

            return null;
        }
    }
}
