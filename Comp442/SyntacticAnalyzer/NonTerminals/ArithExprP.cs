using LexicalAnalyzer;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool ArithExprP()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = AtoCC.Convert(lookaheadToken);

            if ("+ - or".HasToken(lookahead)) {
                this.ApplyDerivation("arithExprP -> addOp term arithExprP");
                if (AddOp() && Term() && ArithExprP()) {
                    return true;
                }
            }

            if ("eq neq lt gt leq ge ] ) ; ,".HasToken(lookahead)) {
                this.ApplyDerivation("arithExprP -> EPSILON");
                return true;
            }

            return false;
        }
    }
}
