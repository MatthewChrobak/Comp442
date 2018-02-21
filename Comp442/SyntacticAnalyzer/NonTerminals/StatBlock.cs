namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool StatBlock()
        {
            string first = "{ id if for get put return";
            string follow = "else ;";
            this.SkipErrors(first, follow);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if ("{".HasToken(lookahead)) {
                this.ApplyDerivation("statBlock -> '{' infStatement '}'");
                if (Match("{") & InfStatement() & Match("}")) {
                    return true;
                }
            }

            if ("id if for get put return".HasToken(lookahead)) {
                this.ApplyDerivation("statBlock -> statement");
                if (Statement()) {
                    return true;
                }
            }

            if (follow.HasToken(lookahead)) {
                this.ApplyDerivation("statBlock -> EPSILON");
                return true;
            }

            return false;
        }
    }
}
