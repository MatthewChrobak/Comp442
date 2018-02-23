using SyntacticAnalyzer.Nodes;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private object ArithExprP(object term)
        {
            string first = "+ - or";
            string follow = "eq neq lt gt leq geq ] ) ; ,";
            this.SkipErrors(first, follow);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("arithExprP -> addOp term arithExprP");

                var arithExpr = new AddOp();

                string op = AddOp();
                object nextTerm = Term();
                object trailingExpr = ArithExprP(nextTerm);

                arithExpr.LHS = term;
                arithExpr.Operator = op;
                arithExpr.RHS = trailingExpr;

                return arithExpr;
            }

            if (follow.HasToken(lookahead)) {
                this.ApplyDerivation("arithExprP -> EPSILON");
                return term;
            }

            return null;
        }
    }
}
