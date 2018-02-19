using LexicalAnalyzer;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool TermP()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = AtoCC.Convert(lookaheadToken);

            if ("* / and".HasToken(lookahead)) {
                this.ApplyDerivation("termP -> multOp factor termP");
                if (MultOp() && Factor() && TermP()) {
                    return true;
                }
            }

            if ("+ - or eq neq lt gt leq ge ] ) ; ,".HasToken(lookahead)) {
                this.ApplyDerivation("termP -> EPSILON");
                return true;
            }

            return false;
        }
    }
}
