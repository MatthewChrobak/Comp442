using SyntacticAnalyzer.Nodes;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private FuncDefList InfFuncDef()
        {
            string first = "id int float";
            string follow = "program";
            this.SkipErrors(first, follow);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("infFuncDef -> funcDef infFuncDef");

                var functionList = new FuncDefList();

                var function = FuncDef();
                var trailingFunctions = InfFuncDef();

                functionList.Functions.Add(function);
                functionList.Functions.JoinListWhereNotNull(trailingFunctions?.Functions);
                return functionList;
            }

            if (follow.HasToken(lookahead)) {
                this.ApplyDerivation("infFuncDef -> EPSILON");
                return new FuncDefList();
            }

            return null;
        }
    }
}
