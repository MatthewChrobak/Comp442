using SyntacticAnalyzer.Nodes;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private FuncDef FuncDef()
        {
            string first = "id int float";
            this.SkipErrors(first);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("funcDef -> funcHead funcBody ';'");

                var function = new FuncDef();

                FuncHead(ref function);
                var body = FuncBody();
                Match(";");

                function.Implementation = body;

                return function;
            }

            return null;
        }
    }
}
