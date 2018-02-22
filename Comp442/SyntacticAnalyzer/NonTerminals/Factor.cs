namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool Factor()
        {
            string first = "intNum floatNum ( not + - id";
            this.SkipErrors(first);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if ("intNum".HasToken(lookahead)) {
                this.ApplyDerivation("factor -> 'intNum'");

                Match("intNum");
            }

            if ("floatNum".HasToken(lookahead)) {
                this.ApplyDerivation("factor -> 'floatNum'");

                Match("floatNum");
            }

            if ("(".HasToken(lookahead)) {
                this.ApplyDerivation("factor -> '(' arithExpr ')'");

                Match("(");
                ArithExpr();
                Match(")");
            }

            if ("not".HasToken(lookahead)) {
                this.ApplyDerivation("factor -> 'not' factor");

                Match("not");
                Factor();
            }

            if ("+ -".HasToken(lookahead)) {
                this.ApplyDerivation("factor -> sign factor");

                Sign();
                Factor();
            }

            if ("id".HasToken(lookahead)) {
                this.ApplyDerivation("factor -> infAccessorDot_AndID_AndVoFC");

                InfAccessorDot_AndID_AndVoFC();
            }

            return false;
        }
    }
}
