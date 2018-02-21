namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool FuncHead()
        {
            string first = "id int float";
            this.SkipErrors(first);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("funcHead -> type optSR_AndID '(' fParams ')'");
                if (Type() & OptSR_AndID() & Match("(") & FParams() & Match(")")) {
                    return true;
                }
            }

            return false;
        }
    }
}
