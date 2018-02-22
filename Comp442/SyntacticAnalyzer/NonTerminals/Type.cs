namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool Type()
        {
            string first = "id int float";
            this.SkipErrors(first);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if ("id".HasToken(lookahead)) {
                this.ApplyDerivation("type -> 'id'");

                Match("id");
            }

            if ("int float".HasToken(lookahead)) {
                this.ApplyDerivation("type -> type_NoID");

                Type_NoID();
            }

            return false;
        }
    }
}
