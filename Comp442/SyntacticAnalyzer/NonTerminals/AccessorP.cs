using SyntacticAnalyzer.Nodes;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        // This reterns either a data member or a function call.
        private object AccessorP(string id)
        {
            string first = "( [";
            string follow = ". * / and + - or eq neq lt gt leq geq ] ) ; ,";
            this.SkipErrors(first, follow);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if ("(".HasToken(lookahead)) {
                this.ApplyDerivation("accessorP -> '(' aParams ')'");

                var functionCall = new FCall(lookaheadToken.SourceLocation);
                functionCall.Id = id;

                Match("(");
                functionCall.Parameters = AParams();
                Match(")");

                return functionCall;
            }

            if ("[".HasToken(lookahead)) {
                this.ApplyDerivation("accessorP -> infIndice");

                var dataMember = new DataMember(lookaheadToken.SourceLocation);
                dataMember.Id = id;
                dataMember.Indexes = InfIndice();
                return dataMember;
            }

            if (follow.HasToken(lookahead)) {
                this.ApplyDerivation("accessorP -> infIndice");
                this.ApplyDerivation("infIndice -> EPSILON");
                return new DataMember(lookaheadToken.SourceLocation) { Id = id };
            }

            return null;
        }
    }
}
