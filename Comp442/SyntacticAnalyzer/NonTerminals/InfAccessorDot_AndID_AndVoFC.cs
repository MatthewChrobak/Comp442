using SyntacticAnalyzer.Nodes;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        // This can be a function call or a variable.
        private Var InfAccessorDot_AndID_AndVoFC()
        {
            string first = "id";
            this.SkipErrors(first);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("infAccessorDot_AndID_AndVoFC -> 'id' infAccessorDot_AndID_AndVoFCP");

                string id = Match("id");
                return InfAccessorDot_AndID_AndVoFCP(id);
            }

            return null;
        }
    }
}
