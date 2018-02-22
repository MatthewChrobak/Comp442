namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool NoASS()
        {
            string first = "if for get put return";
            this.SkipErrors(first);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if ("if".HasToken(lookahead)) {
                this.ApplyDerivation("noASS -> 'if' '(' expr ')' 'then' statBlock 'else' statBlock ';'");

                Match("if");
                Match("(");
                Expr();
                Match(")");
                Match("then");
                StatBlock();
                Match("else");
                StatBlock();
                Match(";");
            }

            if ("for".HasToken(lookahead)) {
                this.ApplyDerivation("noASS -> 'for' '(' type 'id' '=' expr ';' relExpr ';' assignStat ')' statBlock ';'");

                Match("for");
                Match("(");
                Type();
                Match("id");
                Match("=");
                Expr();
                Match(";");
                RelExpr();
                Match(";");
                AssignStat();
                Match(")");
                StatBlock();
                Match(";");
            }

            if ("get".HasToken(lookahead)) {
                this.ApplyDerivation("noASS -> 'get' '(' variable ')' ';'");

                Match("get");
                Match("(");
                Variable();
                Match(")");
                Match(";");
            }

            if ("put".HasToken(lookahead)) {
                this.ApplyDerivation("noASS -> 'put' '(' expr ')' ';'");
                Match("put");
                Match("(");
                Expr();
                Match(")");
                Match(";");
            }

            if ("return".HasToken(lookahead)) {
                this.ApplyDerivation("noASS -> 'return' '(' expr ')' ';'");

                Match("return");
                Match("(");
                Expr();
                Match(")");
                Match(";");
            }

            return false;
        }
    }
}
