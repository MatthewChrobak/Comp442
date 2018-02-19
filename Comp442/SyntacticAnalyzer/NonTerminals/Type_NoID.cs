using LexicalAnalyzer;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool Type_NoID()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = lookaheadToken.AToCC();

            if ("int".HasToken(lookahead)) {
                this.ApplyDerivation("type_NoID -> 'int'");
                if (Match("int")) {
                    return true;
                }
            }

            if ("float".HasToken(lookahead)) {
                this.ApplyDerivation("type_NoID -> 'float'");
                if (Match("float")) {
                    return true;
                }
            }

            return false;
        }
    }
}
