using LexicalAnalyzer;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool OptSR_AndID()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = lookaheadToken.AToCC();

            if ("id".HasToken(lookahead)) {
                this.ApplyDerivation("optSR_AndID -> 'id' optSR_AndIDP");
                if (Match("id") && OptSR_AndIDP()) {
                    return true;
                }
            }

            return false;
        }
    }
}
