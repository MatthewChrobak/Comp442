using LexicalAnalyzer;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool AccessorP()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = AtoCC.Convert(lookaheadToken);

            if ("(".HasToken(lookahead)) {
                this.ApplyDerivation("accessorP -> '(' aParams ')'");
                if (Match("(") && AParams() && Match(")")) {
                    return true;
                }
            }

            if ("[".HasToken(lookahead)) {
                this.ApplyDerivation("accessorP -> infIndice");
                if (InfIndice()) {
                    return true;
                }
            }

            if (". * / and + - or eq neq lt gt leq ge ] ) ; ,".HasToken(lookahead)) {
                this.ApplyDerivation("accessorP -> infIndice");
                this.ApplyDerivation("infIndice -> EPSILON");
                return true;
            }

            return false;
        }
    }
}
