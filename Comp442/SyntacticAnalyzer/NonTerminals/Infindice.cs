namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool InfIndice()
        {
            string first = "[";
            string follow = ". * / and + - or eq neq lt gt leq geq ] ) ; , =";

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("infIndice -> indice infIndice");
                if (Indice() & InfIndice()) {
                    return true;
                }
            }

            if (follow.HasToken(lookahead)) {
                this.ApplyDerivation("infIndice -> EPSILON");
                return true;
            }

            return false;
        }
    }
}
