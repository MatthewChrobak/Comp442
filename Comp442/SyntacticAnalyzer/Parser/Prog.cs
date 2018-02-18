using LexicalAnalyzer;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        public bool Prog()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = AtoCC.Convert(lookaheadToken);

            // Do we have the lookahead?
            if ("program class id int float".HasToken(lookahead)) {
                // Parse the rest.
                if (InfClassDecl() /*&& infFuncDef()*/ && Match("program") && FuncBody() && Match(";")) {
                    return true;
                }
            }

            return false;
        }
    }
}
