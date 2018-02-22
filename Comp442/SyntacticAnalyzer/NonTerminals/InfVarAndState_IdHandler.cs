using SyntacticAnalyzer.Nodes;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private StatBlock InfVarAndState_IdHandler(string id)
        {
            string first = "id ( [ . =";
            this.SkipErrors(first);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if ("id".HasToken(lookahead)) {
                this.ApplyDerivation("infVarAndState_IdHandler -> 'id' infArraySize ';' infVarAndState");

                // This is variable declaration.
                var block = new StatBlock();
                var variable = new VarDecl();

                string variableId = Match("id");
                var dimensions = InfArraySize();
                Match(";");
                var trailingBlock = InfVarAndState();

                variable.Id = variableId;
                variable.Type = id;
                variable.Dimensions = dimensions;

                block.Statements.Add(variable);
                block.Statements.JoinListWhereNotNull(trailingBlock?.Statements);

                return block;
            }

            if ("( [ . =".HasToken(lookahead)) {
                this.ApplyDerivation("infVarAndState_IdHandler -> variableP '=' expr ';' infStatement");

                // NoASS would have caught the other statements.
                var block = new StatBlock();
                var statement = new AssignStat();

                var variable = VariableP(id);
                Match("=");
                var expr = Expr();
                Match(";");
                var trailingStatements = InfStatement();

                statement.Variable = variable;
                statement.ExpressionValue = expr;

                block.Statements.Add(statement);
                block.Statements.JoinListWhereNotNull(trailingStatements?.Statements);

                return block;
            }

            return null;
        }
    }
}
