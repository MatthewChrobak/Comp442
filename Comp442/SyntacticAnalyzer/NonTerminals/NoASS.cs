using SyntacticAnalyzer.Nodes;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private object NoASS()
        {
            string first = "if for get put return";
            this.SkipErrors(first);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if ("if".HasToken(lookahead)) {
                this.ApplyDerivation("noASS -> 'if' '(' expr ')' 'then' statBlock 'else' statBlock ';'");

                var ifStatement = new IfStat(lookaheadToken.SourceLocation);

                Match("if");
                Match("(");
                var expr = Expr();
                Match(")");
                Match("then");
                var trueBlock = StatBlock();
                Match("else");
                var elseBlock = StatBlock();
                Match(";");

                ifStatement.Condition = expr;
                ifStatement.TrueBlock = trueBlock;
                ifStatement.ElseBlock = elseBlock;

                return ifStatement;
            }

            if ("for".HasToken(lookahead)) {
                this.ApplyDerivation("noASS -> 'for' '(' type 'id' '=' expr ';' relExpr ';' assignStat ')' statBlock ';'");

                var forStat = new ForStat(lookaheadToken.SourceLocation);

                Match("for");
                Match("(");
                string type = Type();
                var idLocation = this.TokenStream.Peek().SourceLocation;
                string id = Match("id");
                Match("=");
                var initExpr = Expr();
                Match(";");
                var condition = RelExpr();
                Match(";");
                var assignStat = AssignStat();
                Match(")");
                var statBlock = StatBlock();
                Match(";");

                forStat.Type = type;
                forStat.Id = id;
                forStat.Initialization = initExpr;
                forStat.Condition = condition;
                forStat.Update = assignStat;
                forStat.LoopBlock = statBlock;
                forStat.IdLocation = idLocation;

                return forStat;
            }

            if ("get".HasToken(lookahead)) {
                this.ApplyDerivation("noASS -> 'get' '(' variable ')' ';'");

                var getStatement = new GetStat(lookaheadToken.SourceLocation);

                Match("get");
                Match("(");
                var variable = Variable();
                Match(")");
                Match(";");

                getStatement.Variable = variable;

                return getStatement;
            }

            if ("put".HasToken(lookahead)) {
                this.ApplyDerivation("noASS -> 'put' '(' expr ')' ';'");

                var putStatement = new PutStat(lookaheadToken.SourceLocation);

                Match("put");
                Match("(");
                var expr = Expr();
                Match(")");
                Match(";");

                putStatement.Expression = expr;

                return putStatement;
            }

            if ("return".HasToken(lookahead)) {
                this.ApplyDerivation("noASS -> 'return' '(' expr ')' ';'");

                var returnStatement = new ReturnStat(lookaheadToken.SourceLocation);

                Match("return");
                Match("(");
                var expr = Expr();
                Match(")");
                Match(";");

                returnStatement.ReturnValueExpression = expr;
                return returnStatement;
            }

            return null;
        }
    }
}
