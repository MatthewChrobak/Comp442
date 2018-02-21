namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool InfFuncDef()
        {
            string first = "id int float";
            string follow = "program";
            this.SkipErrors(first, follow);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("infFuncDef -> funcDef infFuncDef");
                if (FuncDef() & InfFuncDef()) {
                    return true;
                }
            }

            if (follow.HasToken(lookahead)) {
                this.ApplyDerivation("infFuncDef -> EPSILON");
                return true;
            }

            return false;
        }
    }
}
