using LexicalAnalyzer;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool FuncDef()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = lookaheadToken.AToCC();

            if ("id int float".HasToken(lookahead)) {
                this.ApplyDerivation("funcDef -> funcHead funcBody ';'");
                if (FuncHead() && FuncBody() && Match(";")) {
                    return true;
                }
            }

            return false;
        }
    }
}
