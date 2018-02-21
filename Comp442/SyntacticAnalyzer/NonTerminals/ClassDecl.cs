namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool ClassDecl()
        {
            string first = "class";
            this.SkipErrors(first);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("classDecl -> 'class' 'id' optInheritance '{' infVarAndFunc_VarStart '}' ';'");
                if (Match("class") & Match("id") & OptInheritance() & Match("{") & InfVarAndFunc_VarStart() & Match("}") & Match(";")) {
                    return true;
                }
            }
            
            return false;
        }
    }
}
