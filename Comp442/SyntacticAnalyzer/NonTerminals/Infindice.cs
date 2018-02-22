using SyntacticAnalyzer.Nodes;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private IndexList InfIndice()
        {
            string first = "[";
            string follow = ". * / and + - or eq neq lt gt leq geq ] ) ; , =";

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("infIndice -> indice infIndice");

                var indexList = new IndexList();

                object expr = Indice();
                var trailingExpr = InfIndice();

                indexList.Expressions.Add(expr);
                indexList.Expressions.JoinListWhereNotNull(trailingExpr?.Expressions);

                return indexList;
            }

            if (follow.HasToken(lookahead)) {
                this.ApplyDerivation("infIndice -> EPSILON");
                return new IndexList();
            }

            return null;
        }
    }
}
