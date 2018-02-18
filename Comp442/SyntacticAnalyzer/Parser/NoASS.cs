using LexicalAnalyzer;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool NoASS()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = AtoCC.Convert(lookaheadToken);

            if ("if".HasToken(lookahead)) {
                if (Match("if") && Match("(") && Expr() && Match(")") && Match("then") && StatBlock() && Match("else") && StatBlock() && Match(";")) {
                    return true;
                }
            }

            if ("for".HasToken(lookahead)) {
                if (Match("for") && Match("(") && 
                    Type() && Match("id") && Match("=") && Expr() && Match(";") && 
                    RelExpr() && Match(";") && 
                    AssignStat() && Match(")") 
                    && StatBlock() && Match(";")) {
                    return true;
                }
            }

            if ("get".HasToken(lookahead)) {
                if (Match("get") && Match("(") && Variable() && Match(")") && Match(";")) {
                    return true;
                }
            }

            if ("put".HasToken(lookahead)) {
                if (Match("put") && Match("(") && Expr() && Match(")") && Match(";")) {
                    return true;
                }
            }

            if ("return".HasToken(lookahead)) {
                if (Match("return") && Match("(") && Expr() && Match(")") && Match(";")) {
                    return true;
                }
            }

            return false;
        }
    }
}
