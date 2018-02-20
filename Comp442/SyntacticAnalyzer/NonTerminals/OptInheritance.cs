namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool OptInheritance()
        {
            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (":".HasToken(lookahead)) {
                this.ApplyDerivation("optInheritance -> ':' 'id' infIdTrail");
                if (Match(":") && Match("id") && InfIdTrail()) {
                    return true;
                }
            }

            if ("{".HasToken(lookahead)) {
                this.ApplyDerivation("optInheritance -> EPSILON");
                return true;
            }

            return false;
        }
    }
}
