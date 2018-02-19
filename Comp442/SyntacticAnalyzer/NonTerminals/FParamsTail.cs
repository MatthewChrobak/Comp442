namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool FParamsTail()
        {
            this.ApplyDerivation("fParamsTail -> ',' type 'id' infArraySize");
            if (Match(",") && Type() && Match("id") && InfArraySize()) {
                return true;
            }

            return false;
        }
    }
}
