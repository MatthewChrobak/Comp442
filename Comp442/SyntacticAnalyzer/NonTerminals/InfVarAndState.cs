using LexicalAnalyzer;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool InfVarAndState()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = lookaheadToken.AToCC();

            if ("id".HasToken(lookahead)) {
                this.ApplyDerivation("infVarAndState -> 'id' infVarAndState_IdHandler");
                if (Match("id") && InfVarAndState_IdHandler()) {
                    return true;
                }
            }

            if ("float int".HasToken(lookahead)) {
                this.ApplyDerivation("infVarAndState -> type_NoID 'id' infArraySize ';' infVarAndState");
                if (Type_NoID() && Match("id") && InfArraySize() && Match(";") && InfVarAndState()) {
                    return true;
                }
            }

            if ("if for get put return".HasToken(lookahead)) {
                this.ApplyDerivation("infVarAndState -> noASS infStatement");
                if (NoASS() && InfStatement()) {
                    return true;
                }
            }

            if ("}".HasToken(lookahead)) {
                this.ApplyDerivation("infVarAndState -> EPSILON");
                return true;
            }

            return false;
        }
    }
}
