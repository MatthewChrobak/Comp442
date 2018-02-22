namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private string ArraySize()
        {
            string first = "[";
            this.SkipErrors(first);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("arraySize -> '[' 'intNum' ']'");

                Match("[");
                string num = Match("intNum");
                Match("]");

                return num;
            }
            
            return System.String.Empty;
        }
    }
}
