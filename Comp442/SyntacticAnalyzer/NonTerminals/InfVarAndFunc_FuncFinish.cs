using SyntacticAnalyzer.Nodes;
using System.Collections.Generic;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private List<object> InfVarAndFunc_FuncFinish(string type, string id, (int, int) startLocation)
        {
            string first = "(";
            this.SkipErrors(first);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("infVarAndFunc_FuncFinish -> '(' fParams ')' ';' infVarAndFunc_FuncStart");

                var memberList = new List<object>();
                var funcDecl = new FuncDecl(startLocation);

                Match("(");
                var parameters = FParams();
                Match(")");
                Match(";");
                var trailingMembers = InfVarAndFunc_FuncStart();

                funcDecl.Type = type;
                funcDecl.Id = id;
                funcDecl.Parameters = parameters;

                memberList.Add(funcDecl);
                memberList.JoinListWhereNotNull(trailingMembers);
                return memberList;
            }

            return null;
        }
    }
}
