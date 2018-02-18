using LexicalAnalyzer;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        public bool InfVarAndFunc_FuncFinish()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = AtoCC.Convert(lookaheadToken);

            if ("(".HasToken(lookahead)) {
                if (Match("(") && FParams() && Match(")") && Match(";") && InfVarAndFunc_FuncStart()) {
                    return true;
                }
            }

            return false;
        }
    }
}
