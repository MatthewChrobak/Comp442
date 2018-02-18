using LexicalAnalyzer;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool Factor()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = AtoCC.Convert(lookaheadToken);

            if ("intNum".HasToken(lookahead)) {
                if (Match("intNum")) {
                    return true;
                }
            }

            if ("floatNum".HasToken(lookahead)) {
                if (Match("floatNum")) {
                    return true;
                }
            }

            if ("(".HasToken(lookahead)) {
                if (Match("(") && ArithExpr() && Match(")")) {
                    return true;
                }
            }

            if ("not".HasToken(lookahead)) {
                if (Match("not") && Factor()) {
                    return true;
                }
            }

            if ("+ -".HasToken(lookahead)) {
                if (Sign() && Factor()) {
                    return true;
                }
            }

            if ("id".HasToken(lookahead)) {
                if (InfAccessorDot_AndID_AndVoFC()) {
                    return true;
                }
            }

            return false;
        }
    }
}
