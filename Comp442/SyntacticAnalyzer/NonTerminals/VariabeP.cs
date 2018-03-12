using SyntacticAnalyzer.Nodes;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private Var VariableP(string id, (int, int) varStartLocation, (int, int) elementStartLocation)
        {
            string first = "( [ .";
            string follow = "= )";
            this.SkipErrors(first, follow);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if ("(".HasToken(lookahead)) {
                this.ApplyDerivation("variableP -> '(' aParams ')' '.' 'id' variableP");

                var variable = new Var(varStartLocation);
                var functionCall = new FCall(elementStartLocation);

                Match("(");
                var parameters = AParams();
                Match(")");
                Match(".");

                var nextLocation = this.TokenStream.Peek().SourceLocation;

                string nextId = Match("id");
                var trailingVariableElements = VariableP(nextId, varStartLocation, nextLocation);

                functionCall.Id = id;
                functionCall.Parameters = parameters;

                variable.Elements.Add(parameters);
                variable.Elements.JoinListWhereNotNull(trailingVariableElements?.Elements);

                return variable;
            }

            if ("[ .".HasToken(lookahead)) {
                this.ApplyDerivation("variableP -> infIndice variablePP");

                var variable = new Var(varStartLocation);
                var member = new DataMember(elementStartLocation);

                var indice = InfIndice();
                var trailingElements = VariablePP(varStartLocation);

                member.Id = id;
                member.Indexes = indice;

                variable.Elements.Add(member);
                variable.Elements.JoinListWhereNotNull(trailingElements?.Elements);

                return variable;
            }

            if (follow.HasToken(lookahead)) {
                this.ApplyDerivation("variableP -> infIndice variablePP");
                this.ApplyDerivation("infIndice -> EPSILON");
                this.ApplyDerivation("variablePP -> EPSILON");

                var variable = new Var(varStartLocation);
                variable.Elements.Add(new DataMember(elementStartLocation) { Id = id });
                return variable;
            }

            return null;
        }
    }
}
