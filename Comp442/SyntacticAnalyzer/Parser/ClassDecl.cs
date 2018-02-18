namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool ClassDecl()
        {
            if (Match("class") && Match("id") && OptInheritance() && Match("{") && InfVarAndFunc_VarStart() && Match("}") && Match(";")) {
                return true;
            }

            return false;
        }
    }
}
