namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool FParams()
        {
            string first = "id int float";
            string follow = ")";
            this.SkipErrors(first, follow);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("fParams -> type 'id' infArraySize infFParamsTail");

                Type();
                Match("id");
                InfArraySize();
                InfFParamsTail();
            }

            if (follow.HasToken(lookahead)) {
                this.ApplyDerivation("fParams -> EPSILON");
                return true;
            }

            return false;
        }
    }
}
