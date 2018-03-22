using SyntacticAnalyzer.Nodes;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        // This can be either a function call or a variable.
        private Var InfAccessorDot_AndID_AndVoFCP(string id, (int, int) startLocation)
        {
            string first = "[ ( .";
            string follow = "* / and + - or eq neq lt gt leq geq ] ) ; ,";
            this.SkipErrors(first, follow);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if ("[ (".HasToken(lookahead)) {
                this.ApplyDerivation("infAccessorDot_AndID_AndVoFCP -> accessorP infAccessorDot_AndID_AndVoFCPP");

                var variable = new Var(startLocation);

                var funcOrDataMemeber = AccessorP(id, startLocation);
                var trailingFuncOrDataMembers = InfAccessorDot_AndID_AndVoFCPP();

                variable.Elements.Add(funcOrDataMemeber);
                variable.Elements.JoinListWhereNotNull(trailingFuncOrDataMembers?.Elements);

                return variable;
            }

            if (".".HasToken(lookahead)) {
                this.ApplyDerivation("infAccessorDot_AndID_AndVoFCP -> accessorP infAccessorDot_AndID_AndVoFCPP");
                this.ApplyDerivation("accessorP -> EPSILON");

                var variable = new Var(startLocation);
                var dataMember = new DataMember(startLocation);

                var trailingFuncOrDataMembers = InfAccessorDot_AndID_AndVoFCPP();

                dataMember.Id = id;

                variable.Elements.Add(dataMember);
                variable.Elements.JoinListWhereNotNull(trailingFuncOrDataMembers?.Elements);

                return variable;
            }

            if (follow.HasToken(lookahead)) {
                this.ApplyDerivation("infAccessorDot_AndID_AndVoFCP -> accessorP infAccessorDot_AndID_AndVoFCPP");
                this.ApplyDerivation("accessorP -> EPSILON");
                this.ApplyDerivation("infAccessorDot_AndID_AndVoFCPP -> EPSILON");
                return new Var(startLocation) { Elements = { new DataMember(startLocation) { Id = id } } };
            }

            return null;
        }
    }
}
