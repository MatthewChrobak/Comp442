using LexicalAnalyzer;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool Variable()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = AtoCC.Convert(lookaheadToken);

            if ("id".HasToken(lookahead)) {
                this.ApplyDerivation("variable -> 'id' variableP");
                if (Match("id") && VariableP()) {
                    return true;
                }
            }

            return false;
        }
    }
}
