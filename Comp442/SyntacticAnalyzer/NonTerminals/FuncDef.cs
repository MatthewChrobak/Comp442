namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool FuncDef()
        {
            string first = "id int float";
            this.SkipErrors(first);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("funcDef -> funcHead funcBody ';'");

                FuncHead();
                FuncBody();
                Match(";");
            }

            return false;
        }
    }
}
