using SyntacticAnalyzer.Nodes;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private object Factor()
        {
            string first = "intNum floatNum ( not + - id";
            this.SkipErrors(first);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if ("intNum".HasToken(lookahead)) {
                this.ApplyDerivation("factor -> 'intNum'");

                return Match("intNum");
            }

            if ("floatNum".HasToken(lookahead)) {
                this.ApplyDerivation("factor -> 'floatNum'");

                return Match("floatNum");
            }

            if ("(".HasToken(lookahead)) {
                this.ApplyDerivation("factor -> '(' arithExpr ')'");

                Match("(");
                var expression = ArithExpr();
                Match(")");

                return expression;
            }

            if ("not".HasToken(lookahead)) {
                this.ApplyDerivation("factor -> 'not' factor");

                var not = new Not(lookaheadToken.SourceLocation);

                Match("not");
                not.Factor = Factor();

                return not;
            }

            if ("+ -".HasToken(lookahead)) {
                this.ApplyDerivation("factor -> sign factor");

                var sign = new Sign(lookaheadToken.SourceLocation);

                sign.SignSymbol = Sign();
                sign.Factor = Factor();

                return sign;
            }

            if ("id".HasToken(lookahead)) {
                this.ApplyDerivation("factor -> infAccessorDot_AndID_AndVoFC");

                return InfAccessorDot_AndID_AndVoFC();
            }

            return null;
        }
    }
}
