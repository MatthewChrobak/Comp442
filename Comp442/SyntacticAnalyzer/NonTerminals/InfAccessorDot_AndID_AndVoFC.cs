namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool InfAccessorDot_AndID_AndVoFC()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if ("id".HasToken(lookahead)) {
                this.ApplyDerivation("infAccessorDot_AndID_AndVoFC -> 'id' infAccessorDot_AndID_AndVoFCP");
                if (Match("id") && InfAccessorDot_AndID_AndVoFCP()) {
                    return true;
                }
            }

            return false;
        }
    }
}
