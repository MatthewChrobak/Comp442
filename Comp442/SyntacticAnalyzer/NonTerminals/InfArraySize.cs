using LexicalAnalyzer;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool InfArraySize()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = AtoCC.Convert(lookaheadToken);

            if ("[".HasToken(lookahead)) {
                this.ApplyDerivation("infArraySize -> arraySize infArraySize");
                if (ArraySize() && InfArraySize()) {
                    return true;
                }
            }

            if (", ; )".HasToken(lookahead)) {
                this.ApplyDerivation("infArraySize -> EPSILON");
                return true;
            }

            return false;
        }
    }
}
