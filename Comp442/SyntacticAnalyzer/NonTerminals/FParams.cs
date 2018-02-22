using SyntacticAnalyzer.Nodes;
using System.Collections.Generic;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private List<FParam> FParams()
        {
            string first = "id int float";
            string follow = ")";
            this.SkipErrors(first, follow);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("fParams -> type 'id' infArraySize infFParamsTail");

                var paramList = new List<FParam>();
                var parameter = new FParam();

                string type = Type();
                string id = Match("id");
                var dimensions = InfArraySize();
                var trailingParameters = InfFParamsTail();

                parameter.Type = type;
                parameter.Id = id;
                parameter.Dimensions = dimensions;

                paramList.Add(parameter);
                paramList.JoinListWhereNotNull(trailingParameters);
                return paramList;
            }

            if (follow.HasToken(lookahead)) {
                this.ApplyDerivation("fParams -> EPSILON");
                return new List<FParam>();
            }

            return null;
        }
    }
}
