using SyntacticAnalyzer.Nodes;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private (ScopeSpec scopeResolution, string id) OptSR_AndIDP(string id, (int, int) startLocation)
        {
            string first = "sr";
            string follow = "(";
            this.SkipErrors(first, follow);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("optSR_AndIDP -> 'sr' 'id'");

                var scopeResolution = new ScopeSpec(startLocation) {
                    ID = id
                };

                Match("sr");
                string functionName = Match("id");

                return (scopeResolution, functionName);
            }

            if (follow.HasToken(lookahead)) {
                this.ApplyDerivation("optSR_AndIDP -> EPSILON");
                return (null, id);
            }

            return (null, System.String.Empty);
        }
    }
}
