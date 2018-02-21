namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool InfAccessorDot_AndID_AndVoFC()
        {
            string first = "id";
            this.SkipErrors(first);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("infAccessorDot_AndID_AndVoFC -> 'id' infAccessorDot_AndID_AndVoFCP");
                if (Match("id") & InfAccessorDot_AndID_AndVoFCP()) {
                    return true;
                }
            }

            return false;
        }
    }
}
