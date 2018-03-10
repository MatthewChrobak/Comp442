using SyntacticAnalyzer.Nodes;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private RelExpr RelExpr()
        {
            string first = "intNum floatNum ( not id + -";
            this.SkipErrors(first);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("relExpr -> arithExpr relOp arithExpr");

                var expr = new RelExpr(lookaheadToken.SourceLocation);

                var lhs = ArithExpr();
                string op = RelOp();
                var rhs = ArithExpr();

                expr.LHS = lhs;
                expr.RelationOperator = op;
                expr.RHS = rhs;

                return expr;
            }

            return null;
        }
    }
}
