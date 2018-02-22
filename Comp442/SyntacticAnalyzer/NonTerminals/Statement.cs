namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool Statement()
        {
            string first = "id";
            string follow = "if for get put return";
            this.SkipErrors(first, follow);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("statement -> assignStat ';'");

                AssignStat();
                Match(";");
            }

            if (follow.HasToken(lookahead)) {
                this.ApplyDerivation("statement -> noASS");

                NoASS();
            }

            return false;
        }
    }
}
