using LexicalAnalyzer;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool Type()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = lookaheadToken.AToCC();

            if ("id".HasToken(lookahead)) {
                this.ApplyDerivation("type -> 'id'");
                if (Match("id")) {
                    return true;
                }
            }

            if ("int float".HasToken(lookahead)) {
                this.ApplyDerivation("type -> type_NoID");
                if (Type_NoID()) {
                    return true;
                }
            }

            return false;
        }
    }
}
