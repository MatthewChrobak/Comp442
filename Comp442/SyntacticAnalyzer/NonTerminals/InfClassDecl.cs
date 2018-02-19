using LexicalAnalyzer;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        public bool InfClassDecl()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = AtoCC.Convert(lookaheadToken);

            if ("class".HasToken(lookahead)) {
                this.ApplyDerivation("infClassDecl -> classDecl infClassDecl");
                if (ClassDecl() && InfClassDecl()) {
                    return true;
                }
            }

            if ("program id int float".HasToken(lookahead)) {
                this.ApplyDerivation("infClassDecl -> EPSILON");
                return true;
            }

            return false;
        }
    }
}
