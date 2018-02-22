namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool Type_NoID()
        {
            string first = "int float";
            this.SkipErrors(first);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if ("int".HasToken(lookahead)) {
                this.ApplyDerivation("type_NoID -> 'int'");

                Match("int");
            }

            if ("float".HasToken(lookahead)) {
                this.ApplyDerivation("type_NoID -> 'float'");

                Match("float");
            }

            return false;
        }
    }
}
