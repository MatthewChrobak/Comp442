namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private string Type()
        {
            string first = "id int float";
            this.SkipErrors(first);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if ("id".HasToken(lookahead)) {
                this.ApplyDerivation("type -> 'id'");

                return Match("id");
            }

            if ("int float".HasToken(lookahead)) {
                this.ApplyDerivation("type -> type_NoID");

                return Type_NoID();
            }

            return System.String.Empty;
        }
    }
}
