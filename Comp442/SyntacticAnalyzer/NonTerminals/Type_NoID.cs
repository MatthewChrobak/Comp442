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
                if (Match("int")) {
                    return true;
                }
            }

            if ("float".HasToken(lookahead)) {
                this.ApplyDerivation("type_NoID -> 'float'");
                if (Match("float")) {
                    return true;
                }
            }

            return false;
        }
    }
}
