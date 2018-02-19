using LexicalAnalyzer;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        public bool Prog()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = lookaheadToken.AToCC();
            
            if ("program class id int float".HasToken(lookahead)) {
                this.ApplyDerivation("prog -> infClassDecl infFuncDef 'program' funcBody ';'");
                if (InfClassDecl() && InfFuncDef() && Match("program") && FuncBody() && Match(";")) {
                    return true;
                }
            }

            return false;
        }
    }
}
