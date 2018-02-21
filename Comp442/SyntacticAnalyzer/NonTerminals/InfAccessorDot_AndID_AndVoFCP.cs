namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool InfAccessorDot_AndID_AndVoFCP()
        {
            string first = "[ ( .";
            string follow = "* / and + - or eq neq lt gt leq geq ] ) ; ,";
            this.SkipErrors(first, follow);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("infAccessorDot_AndID_AndVoFCP -> accessorP infAccessorDot_AndID_AndVoFCPP");
                if (AccessorP() & InfAccessorDot_AndID_AndVoFCPP()) {
                    return true;
                }
            }

            if (follow.HasToken(lookahead)) {
                this.ApplyDerivation("infAccessorDot_AndID_AndVoFCP -> accessorP infAccessorDot_AndID_AndVoFCPP");
                this.ApplyDerivation("accessorP -> EPSILON");
                this.ApplyDerivation("infAccessorDot_AndID_AndVoFCPP -> EPSILON");
                return true;
            }

            return false;
        }
    }
}
