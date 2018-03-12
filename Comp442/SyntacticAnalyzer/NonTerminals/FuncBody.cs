using SyntacticAnalyzer.Nodes;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private StatBlock FuncBody()
        {
            string first = "{";
            this.SkipErrors(first);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("funcBody -> '{' infVarAndState '}'");

                Match("{");
                var block = InfVarAndState(lookaheadToken.SourceLocation);
                Match("}");

                return block;
            }

            return null;
        }
    }
}
