using LexicalAnalyzer;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        // FIRST 'program', epsilon, 'class', 'id', 'int', 'float'
        // FOLLOW $

        public bool Prog()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = AtoCC.Convert(lookaheadToken);

            // Do we have the lookahead?
            if ("program class id int float".HasToken(lookahead)) {
                // Parse the rest.
                if (InfClassDecl() /*&& infFuncDef()*/ && Match("program") /*&& funcBody()*/ && Match(";")) {
                    return true;
                }
            }

            return false;
        }
    }
}
