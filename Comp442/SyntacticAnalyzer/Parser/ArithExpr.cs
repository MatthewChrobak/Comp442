using LexicalAnalyzer;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool ArithExpr()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = AtoCC.Convert(lookaheadToken);

            if ("intNum floatNum ( not id + -".HasToken(lookahead)) {
                if (Term() && ArithExprP()) {
                    return true;
                }
            }

            return false;
        }
    }
}
