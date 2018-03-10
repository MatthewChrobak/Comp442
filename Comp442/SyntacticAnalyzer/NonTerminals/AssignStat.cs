using SyntacticAnalyzer.Nodes;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private AssignStat AssignStat()
        {
            string first = "id";
            this.SkipErrors(first);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("assignStat -> variable '=' expr");

                var assignStatement = new AssignStat(lookaheadToken.SourceLocation);

                var variable = Variable();
                Match("=");
                var expr = Expr();

                assignStatement.Variable = variable;
                assignStatement.ExpressionValue = expr;

                return assignStatement;
            }

            return null;
        }
    }
}
