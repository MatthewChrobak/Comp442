using LexicalAnalyzer;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool Factor()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = lookaheadToken.AToCC();

            if ("intNum".HasToken(lookahead)) {
                this.ApplyDerivation("factor -> intNum");
                if (Match("intNum")) {
                    return true;
                }
            }

            if ("floatNum".HasToken(lookahead)) {
                this.ApplyDerivation("factor -> floatNum");
                if (Match("floatNum")) {
                    return true;
                }
            }

            if ("(".HasToken(lookahead)) {
                this.ApplyDerivation("factor -> '(' arithExpr ')'");
                if (Match("(") && ArithExpr() && Match(")")) {
                    return true;
                }
            }

            if ("not".HasToken(lookahead)) {
                this.ApplyDerivation("factor -> not factor");
                if (Match("not") && Factor()) {
                    return true;
                }
            }

            if ("+ -".HasToken(lookahead)) {
                this.ApplyDerivation("factor -> sign factor");
                if (Sign() && Factor()) {
                    return true;
                }
            }

            if ("id".HasToken(lookahead)) {
                this.ApplyDerivation("factor -> infAccessorDot_AndID_AndVoFC");
                if (InfAccessorDot_AndID_AndVoFC()) {
                    return true;
                }
            }

            return false;
        }
    }
}
