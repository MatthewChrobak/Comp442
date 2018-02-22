using SyntacticAnalyzer.Nodes;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        // Decides whether or not it's a relExpr or arithExpr.
        private object ArithExprOrRelExpr(ArithExpr expression)
        {
            string first = "eq neq lt gt leq geq";
            string follow = ") ; ,";
            this.SkipErrors(first, follow);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("arithExprOrRelExpr -> relOp arithExpr");

                var relExpr = new RelExpr();

                string relationalOperator = RelOp();
                var arithExpr = ArithExpr();

                relExpr.LHS = expression;
                relExpr.RelationOperator = relationalOperator;
                relExpr.RHS = arithExpr;

                return relExpr;
            }

            if (follow.HasToken(lookahead)) {
                this.ApplyDerivation("arithExprOrRelExpr -> EPSILON");
                return expression;
            }

            return null;
        }
    }
}
