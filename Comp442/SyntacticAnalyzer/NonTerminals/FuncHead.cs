using LexicalAnalyzer;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool FuncHead()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = lookaheadToken.AToCC();

            if ("id int float".HasToken(lookahead)) {
                this.ApplyDerivation("funcHead -> type optSR_AndID '(' fParams ')'");
                if (Type() && OptSR_AndID() && Match("(") && FParams() && Match(")")) {
                    return true;
                }
            }

            return false;
        }
    }
}
