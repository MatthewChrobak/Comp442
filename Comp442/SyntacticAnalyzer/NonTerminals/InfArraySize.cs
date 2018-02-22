using System.Collections.Generic;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private List<string> InfArraySize()
        {
            string first = "[";
            string follow = ", ; )";
            this.SkipErrors(first, follow);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("infArraySize -> arraySize infArraySize");

                var dimensionList = new List<string>();

                var dimension = ArraySize();
                var trailingDimensions = InfArraySize();

                dimensionList.Add(dimension);
                dimensionList.JoinListWhereNotNull(trailingDimensions);

                return dimensionList;
            }

            if (follow.HasToken(lookahead)) {
                this.ApplyDerivation("infArraySize -> EPSILON");
                return new List<string>();
            }

            return null;
        }
    }
}
