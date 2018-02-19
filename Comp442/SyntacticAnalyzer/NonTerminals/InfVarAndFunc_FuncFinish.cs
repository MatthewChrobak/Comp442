using LexicalAnalyzer;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        public bool InfVarAndFunc_FuncFinish()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = lookaheadToken.AToCC();

            if ("(".HasToken(lookahead)) {
                this.ApplyDerivation("infVarAndFunc_FuncFinish -> '(' fParams ')' ';' infVarAndFunc_FuncStart");
                if (Match("(") && FParams() && Match(")") && Match(";") && InfVarAndFunc_FuncStart()) {
                    return true;
                }
            }

            return false;
        }
    }
}
