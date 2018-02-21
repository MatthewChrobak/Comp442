namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool Prog()
        {
            string first = "program class id int float";
            this.SkipErrors(first);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();
            
            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("prog -> infClassDecl infFuncDef 'program' funcBody ';'");
                if (InfClassDecl() & InfFuncDef() & Match("program") & FuncBody() & Match(";")) {
                    return true;
                }
            }

            return false;
        }
    }
}
