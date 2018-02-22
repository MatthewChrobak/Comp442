namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private string RelOp()
        {
            string first = "eq neq lt gt leq geq";
            this.SkipErrors(first);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if ("eq".HasToken(lookahead)) {
                this.ApplyDerivation("relOp -> 'eq'");

                return Match("eq");
            }

            if ("neq".HasToken(lookahead)) {
                this.ApplyDerivation("relOp -> 'neq'");

                return Match("neq");
            }

            if ("lt".HasToken(lookahead)) {
                this.ApplyDerivation("relOp -> 'lt'");

                return Match("lt");
            }

            if ("gt".HasToken(lookahead)) {
                this.ApplyDerivation("relOp -> 'gt'");

                return Match("gt");
            }

            if ("leq".HasToken(lookahead)) {
                this.ApplyDerivation("relOp -> 'leq'");

                return Match("leq");
            }

            if ("geq".HasToken(lookahead)) {
                this.ApplyDerivation("relOp -> 'geq'");

                return Match("geq");
            }

            return System.String.Empty;
        }
    }
}
