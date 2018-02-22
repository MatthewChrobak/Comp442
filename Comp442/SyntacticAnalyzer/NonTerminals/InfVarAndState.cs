using SyntacticAnalyzer.Nodes;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private StatBlock InfVarAndState()
        {
            string first = "id float int if for get put return";
            string follow = "}";
            this.SkipErrors(first, follow);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if ("id".HasToken(lookahead)) {
                this.ApplyDerivation("infVarAndState -> 'id' infVarAndState_IdHandler");

                var block = new StatBlock();

                string id = Match("id");
                var trailingBlock = InfVarAndState_IdHandler(id);
                
                block.Statements.JoinListWhereNotNull(trailingBlock?.Statements);

                return block;
            }

            if ("float int".HasToken(lookahead)) {
                this.ApplyDerivation("infVarAndState -> type_NoID 'id' infArraySize ';' infVarAndState");

                var block = new StatBlock();
                var variableDeclaration = new VarDecl();

                string type = Type_NoID();
                string id = Match("id");
                var dimensions = InfArraySize();
                Match(";");
                var trailingBlock = InfVarAndState();

                variableDeclaration.Type = type;
                variableDeclaration.Id = id;
                variableDeclaration.Dimensions = dimensions;

                block.Statements.Add(variableDeclaration);
                block.Statements.JoinListWhereNotNull(trailingBlock?.Statements);

                return block;
            }

            if ("if for get put return".HasToken(lookahead)) {
                this.ApplyDerivation("infVarAndState -> noASS infStatement");

                var block = new StatBlock();

                var statement = NoASS();
                var trailingStatements = InfStatement();

                block.Statements.Add(statement);
                block.Statements.JoinListWhereNotNull(trailingStatements?.Statements);

                return block;
            }

            if (follow.HasToken(lookahead)) {
                this.ApplyDerivation("infVarAndState -> EPSILON");
                return new StatBlock();
            }

            return null;
        }
    }
}
