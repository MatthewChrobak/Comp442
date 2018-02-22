using SyntacticAnalyzer.Nodes;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private Var VariableP(string id)
        {
            string first = "( [ .";
            string follow = "= )";
            this.SkipErrors(first, follow);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if ("(".HasToken(lookahead)) {
                this.ApplyDerivation("variableP -> '(' aParams ')' '.' 'id' variableP");

                var variable = new Var();
                var functionCall = new FCall();

                Match("(");
                var parameters = AParams();
                Match(")");
                Match(".");
                string nextId = Match("id");
                var trailingVariableElements = VariableP(nextId);

                functionCall.Id = id;
                functionCall.Parameters = parameters;

                variable.Elements.Add(parameters);
                variable.Elements.JoinListWhereNotNull(trailingVariableElements?.Elements);

                return variable;
            }

            if ("[ .".HasToken(lookahead)) {
                this.ApplyDerivation("variableP -> infIndice variablePP");

                var variable = new Var();
                var member = new DataMember();

                var indice = InfIndice();
                var trailingElements = VariablePP();

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

                var variable = new Var();
                variable.Elements.Add(new DataMember() { Id = id });
                return variable;
            }

            return null;
        }
    }
}
