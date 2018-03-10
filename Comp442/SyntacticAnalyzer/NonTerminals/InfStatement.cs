using SyntacticAnalyzer.Nodes;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private StatBlock InfStatement()
        {
            string first = "id if for get put return";
            string follow = "}";
            this.SkipErrors(first, follow);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("infStatement -> statement infStatement");

                var block = new StatBlock(lookaheadToken.SourceLocation);

                var statement = Statement();
                var trailingBlock = InfStatement();

                block.Statements.Add(statement);
                block.Statements.JoinListWhereNotNull(trailingBlock?.Statements);

                return block;
            }

            if (follow.HasToken(lookahead)) {
                this.ApplyDerivation("infStatement -> EPSILON");
                return new StatBlock(lookaheadToken.SourceLocation);
            }

            return null;
        }
    }
}
