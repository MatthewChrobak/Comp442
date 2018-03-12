using SyntacticAnalyzer.Nodes;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private Var VariablePP((int, int) varStartLocation)
        {
            string first = ".";
            string follow = "= )";
            this.SkipErrors(first, follow);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("variablePP -> '.' 'id' variableP");

                Match(".");
                var startLocation = this.TokenStream.Peek().SourceLocation;
                string id = Match("id");
                return VariableP(id, varStartLocation, startLocation);
            }

            if (follow.HasToken(lookahead)) {
                this.ApplyDerivation("variablePP -> EPSILON");
                return new Var(lookaheadToken.SourceLocation);
            }

            return null;
        }
    }
}
