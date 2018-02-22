using SyntacticAnalyzer.Nodes;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private AParams InfAParamsTail()
        {
            string first = ",";
            string follow = ")";
            this.SkipErrors(first, follow);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("infAParamsTail -> aParamsTail infAParamsTail");

                var aparams = new AParams();

                var expr = AParamsTail();
                var trailingAParams = InfAParamsTail();

                aparams.Expressions.Add(expr);
                aparams.Expressions.JoinListWhereNotNull(trailingAParams?.Expressions);

                return aparams;
            }

            if (follow.HasToken(lookahead)) {
                this.ApplyDerivation("infAParamsTail -> EPSILON");
                return new AParams();
            }

            return null;
        }
    }
}
