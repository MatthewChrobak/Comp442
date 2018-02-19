using LexicalAnalyzer;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool InfFParamsTail()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = AtoCC.Convert(lookaheadToken);

            if (",".HasToken(lookahead)) {
                this.ApplyDerivation("infFParamsTail -> fParamsTail infFParamsTail");
                if (FParamsTail() && InfFParamsTail()) {
                    return true;
                }
            }

            if (")".HasToken(lookahead)) {
                this.ApplyDerivation("infFParamsTail -> EPSILON");
                return true;
            }

            return false;
        }
    }
}
