using SyntacticAnalyzer.Nodes;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private Node ArithExpr()
        {
            string first = "intNum floatNum ( not id + -";
            this.SkipErrors(first);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("arithExpr -> term arithExprP");

                var term = Term();
                return ArithExprP(term);
            }

            return null;
        }
    }
}
