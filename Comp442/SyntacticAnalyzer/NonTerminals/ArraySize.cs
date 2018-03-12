using SyntacticAnalyzer.Nodes;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private Integer ArraySize()
        {
            string first = "[";
            this.SkipErrors(first);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("arraySize -> '[' 'intNum' ']'");

                Match("[");
                var location = this.TokenStream.Peek().SourceLocation;
                string num = Match("intNum");
                Match("]");

                return new Integer(location) { Value = num };
            }
            
            return null;
        }
    }
}
