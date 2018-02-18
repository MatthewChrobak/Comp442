using LexicalAnalyzer;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool OptInheritance()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = AtoCC.Convert(lookaheadToken);

            if (":".HasToken(lookahead)) {
                if (Match(":") && Match("id") && InfIdTrail()) {
                    return true;
                }
            } else {
                if ("{".HasToken(lookahead)) {
                    return true;
                }
            }

            return false;
        }
    }
}
