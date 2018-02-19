using LexicalAnalyzer;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool InfFuncDef()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = AtoCC.Convert(lookaheadToken);

            if ("id int float".HasToken(lookahead)) {
                if (FuncDef() && InfFuncDef()) {
                    return true;
                }
            }

            if ("program".HasToken(lookahead)) {
                return true;
            }

            return false;
        }
    }
}
