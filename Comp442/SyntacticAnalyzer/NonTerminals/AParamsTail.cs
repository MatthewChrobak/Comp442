namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool AParamsTail()
        {
            this.ApplyDerivation("aParamsTail -> ',' expr");

            if (Match(",") && Expr()) {
                return true;
            }

            return false;
        }
    }
}
