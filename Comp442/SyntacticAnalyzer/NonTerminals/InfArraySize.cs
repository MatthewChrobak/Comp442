using SyntacticAnalyzer.Nodes;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private DimList InfArraySize()
        {
            string first = "[";
            string follow = ", ; )";
            this.SkipErrors(first, follow);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("infArraySize -> arraySize infArraySize");

                var dimentionList = new DimList();

                var dimention = ArraySize();
                var trailingDimentions = InfArraySize();

                dimentionList.Numbers.Add(dimention);
                dimentionList.Numbers.JoinListWhereNotNull(trailingDimentions?.Numbers);

                return dimentionList;
            }

            if (follow.HasToken(lookahead)) {
                this.ApplyDerivation("infArraySize -> EPSILON");
                return new DimList();
            }

            return null;
        }
    }
}
