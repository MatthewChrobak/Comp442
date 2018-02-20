namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool NoASS()
        {
            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if ("if".HasToken(lookahead)) {
                this.ApplyDerivation("noASS -> 'if' '(' expr ')' 'then' statBlock 'else' statBlock ';'");
                if (Match("if") && Match("(") && Expr() && Match(")") && Match("then") && StatBlock() && Match("else") && StatBlock() && Match(";")) {
                    return true;
                }
            }

            if ("for".HasToken(lookahead)) {
                this.ApplyDerivation("noASS -> 'for' '(' type 'id' '=' expr ';' relExpr ';' assignStat ')' statBlock ';'");
                if (Match("for") && Match("(") && 
                    Type() && Match("id") && Match("=") && Expr() && Match(";") && 
                    RelExpr() && Match(";") && 
                    AssignStat() && Match(")") 
                    && StatBlock() && Match(";")) {
                    return true;
                }
            }

            if ("get".HasToken(lookahead)) {
                this.ApplyDerivation("noASS -> 'get' '(' variable ')' ';'");
                if (Match("get") && Match("(") && Variable() && Match(")") && Match(";")) {
                    return true;
                }
            }

            if ("put".HasToken(lookahead)) {
                this.ApplyDerivation("noASS -> 'put' '(' expr ')' ';'");
                if (Match("put") && Match("(") && Expr() && Match(")") && Match(";")) {
                    return true;
                }
            }

            if ("return".HasToken(lookahead)) {
                this.ApplyDerivation("noASS -> 'return' '(' expr ')' ';'");
                if (Match("return") && Match("(") && Expr() && Match(")") && Match(";")) {
                    return true;
                }
            }

            return false;
        }
    }
}
