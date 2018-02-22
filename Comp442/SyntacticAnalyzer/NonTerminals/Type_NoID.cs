namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private string Type_NoID()
        {
            string first = "int float";
            this.SkipErrors(first);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if ("int".HasToken(lookahead)) {
                this.ApplyDerivation("type_NoID -> 'int'");

                return Match("int");
            }

            if ("float".HasToken(lookahead)) {
                this.ApplyDerivation("type_NoID -> 'float'");

                return Match("float");
            }

            return System.String.Empty;
        }
    }
}
