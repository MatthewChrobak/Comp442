using SyntacticAnalyzer.Nodes;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private Node Expr()
        {
            string first = "intNum floatNum ( not id + -";
            this.SkipErrors(first);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("expr -> arithExpr arithExprOrRelExpr");

                var arithExpr = ArithExpr();
                return ArithExprOrRelExpr(arithExpr);
            }

            return null;
        }
    }
}
