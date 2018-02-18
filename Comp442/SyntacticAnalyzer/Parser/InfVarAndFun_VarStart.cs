using LexicalAnalyzer;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool InfVarAndFunc_VarStart()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = AtoCC.Convert(lookaheadToken);

            if ("id int float".HasToken(lookahead)) {
                if (Type() && Match("id") && InfVarAndFunc_VarFinish()) {
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
