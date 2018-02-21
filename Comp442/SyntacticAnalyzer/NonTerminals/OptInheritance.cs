namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool OptInheritance()
        {
            string first = ":";
            string follow = "{";

            this.SkipErrors(first, follow);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("optInheritance -> ':' 'id' infIdTrail");
                if (Match(":") & Match("id") & InfIdTrail()) {
                    return true;
                }
            }

            if (follow.HasToken(lookahead)) {
                this.ApplyDerivation("optInheritance -> EPSILON");
                return true;
            }

            return false;
        }
    }
}
