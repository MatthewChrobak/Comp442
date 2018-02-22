using SyntacticAnalyzer.Nodes;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private void FuncHead(ref FuncDef function)
        {
            string first = "id int float";
            this.SkipErrors(first);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("funcHead -> type optSR_AndID '(' fParams ')'");

                function.ReturnType = Type();
                (ScopeSpec scopeResolution, string functionName) result = OptSR_AndID();
                function.ScopeResolution = result.scopeResolution;
                function.FunctionName = result.functionName;
                Match("(");
                function.Parameters = FParams();
                Match(")");
            }
        }
    }
}
