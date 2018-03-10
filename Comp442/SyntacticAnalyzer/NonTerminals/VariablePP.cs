using SyntacticAnalyzer.Nodes;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private Var VariablePP()
        {
            string first = ".";
            string follow = "= )";
            this.SkipErrors(first, follow);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("variablePP -> '.' 'id' variableP");

                Match(".");
                string id = Match("id");
                return VariableP(id);
            }

            if (follow.HasToken(lookahead)) {
                this.ApplyDerivation("variablePP -> EPSILON");
                return new Var(lookaheadToken.SourceLocation);
            }

            return null;
        }
    }
}
