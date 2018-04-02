using SyntacticAnalyzer.Nodes;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private Node AParamsTail()
        {
            string first = ",";
            this.SkipErrors(first);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("aParamsTail -> ',' expr");

                Match(",");
                return Expr();
            }

            return null;
        }
    }
}
