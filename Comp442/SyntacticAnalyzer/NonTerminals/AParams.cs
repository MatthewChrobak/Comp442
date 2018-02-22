using SyntacticAnalyzer.Nodes;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private AParams AParams()
        {
            string first = "intNum floatNum ( not id + -";
            string follow = ")";
            this.SkipErrors(first, follow);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("aParams -> expr infAParamsTail");

                var aparams = new AParams();

                object expr = Expr();
                var trailingExpr = InfAParamsTail();

                aparams.Expressions.Add(expr);
                aparams.Expressions.JoinListWhereNotNull(trailingExpr?.Expressions);

                return aparams;
            }

            if (follow.HasToken(lookahead)) {
                this.ApplyDerivation("aParams -> EPSILON");
                return new AParams();
            }

            return null;
        }
    }
}
