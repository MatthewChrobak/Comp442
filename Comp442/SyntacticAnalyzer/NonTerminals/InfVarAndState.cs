using LexicalAnalyzer;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool InfVarAndState()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = AtoCC.Convert(lookaheadToken);

            if ("id".HasToken(lookahead)) {
                if (Match("id") && InfVarAndState_IdHandler()) {
                    return true;
                }
            } else if ("float int".HasToken(lookahead)) {
                if (Type_NoID() && Match("id") && InfArraySize() && Match(";") && InfVarAndState()) {
                    return true;
                }
            } else if ("if for get put return".HasToken(lookahead)) {
                if (NoASS() && InfStatement()) {
                    return true;
                }
             } else {
                if ("}".HasToken(lookahead)) {
                    return true;
                }
            }

            return false;
        }
    }
}
