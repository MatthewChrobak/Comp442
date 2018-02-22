using SyntacticAnalyzer.Nodes;
using System.Collections.Generic;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private List<FParam> InfFParamsTail()
        {
            string first = ",";
            string follow = ")";
            this.SkipErrors(first, follow);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("infFParamsTail -> fParamsTail infFParamsTail");

                var paramList = new List<FParam>();

                var parameter = FParamsTail();
                var trailingParams = InfFParamsTail();

                paramList.Add(parameter);
                paramList.JoinListWhereNotNull(trailingParams);
                return paramList;
            }

            if (follow.HasToken(lookahead)) {
                this.ApplyDerivation("infFParamsTail -> EPSILON");
                return new List<FParam>();
            }

            return null;
        }
    }
}
