namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private object Statement()
        {
            string first = "id";
            string follow = "if for get put return";
            this.SkipErrors(first, follow);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("statement -> assignStat ';'");

                var stat = AssignStat();
                Match(";");

                return stat;
            }

            if (follow.HasToken(lookahead)) {
                this.ApplyDerivation("statement -> noASS");

                return NoASS();
            }

            return null;
        }
    }
}
