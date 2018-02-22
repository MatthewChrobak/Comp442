using SyntacticAnalyzer.Nodes;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private FParam FParamsTail()
        {
            string first = ",";
            this.SkipErrors(first);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("fParamsTail -> ',' type 'id' infArraySize");

                var parameter = new FParam();

                Match(",");
                string type = Type();
                string id = Match("id");
                var dimensions = InfArraySize();

                parameter.Type = type;
                parameter.Id = id;
                parameter.Dimensions = dimensions;

                return parameter;
            }

            return null;
        }
    }
}
