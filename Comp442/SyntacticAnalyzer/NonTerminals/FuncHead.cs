using LexicalAnalyzer;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool FuncHead()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = AtoCC.Convert(lookaheadToken);

            if ("id int float".HasToken(lookahead)) {
                if (Type() && OptSR_AndID() && Match("(") && FParams() && Match(")")) {
                    return true;
                }
            }

            return false;
        }
    }
}
