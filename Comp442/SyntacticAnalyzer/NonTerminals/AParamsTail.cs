namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool AParamsTail()
        {
            if (Match(",") && Expr()) {
                return true;
            }

            return false;
        }
    }
}
