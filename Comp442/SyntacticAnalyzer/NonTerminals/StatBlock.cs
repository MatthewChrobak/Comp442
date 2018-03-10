using SyntacticAnalyzer.Nodes;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private StatBlock StatBlock()
        {
            string first = "{ id if for get put return";
            string follow = "else ;";
            this.SkipErrors(first, follow);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if ("{".HasToken(lookahead)) {
                this.ApplyDerivation("statBlock -> '{' infStatement '}'");

                Match("{");
                var block = InfStatement();
                Match("}");

                return block;
            }

            if ("id if for get put return".HasToken(lookahead)) {
                this.ApplyDerivation("statBlock -> statement");

                var statement = Statement();

                return new StatBlock(lookaheadToken.SourceLocation) { Statements = { statement } };
            }

            if (follow.HasToken(lookahead)) {
                this.ApplyDerivation("statBlock -> EPSILON");
                return new StatBlock(lookaheadToken.SourceLocation);
            }

            return null;
        }
    }
}
