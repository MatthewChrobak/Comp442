using LexicalAnalyzer;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool InfIndice()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = lookaheadToken.AToCC();

            if ("[".HasToken(lookahead)) {
                this.ApplyDerivation("infIndice -> indice infIndice");
                if (Indice() && InfIndice()) {
                    return true;
                }
            }

            if (". * / and + - or eq neq lt gt leq ge ] ) ; , =".HasToken(lookahead)) {
                this.ApplyDerivation("infIndice -> EPSILON");
                return true;
            }

            return false;
        }
    }
}
