namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool RelOp()
        {
            string first = "eq neq lt gt leq geq";
            this.SkipErrors(first);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if ("eq".HasToken(lookahead)) {
                this.ApplyDerivation("relOp -> 'eq'");

                Match("eq");
            }

            if ("neq".HasToken(lookahead)) {
                this.ApplyDerivation("relOp -> 'neq'");

                Match("neq");
            }

            if ("lt".HasToken(lookahead)) {
                this.ApplyDerivation("relOp -> 'lt'");

                Match("lt");
            }

            if ("gt".HasToken(lookahead)) {
                this.ApplyDerivation("relOp -> 'gt'");

                Match("gt");
            }

            if ("leq".HasToken(lookahead)) {
                this.ApplyDerivation("relOp -> 'leq'");

                Match("leq");
            }

            if ("geq".HasToken(lookahead)) {
                this.ApplyDerivation("relOp -> 'geq'");

                Match("geq");
            }

            return false;
        }
    }
}
