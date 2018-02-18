namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool FParamsTail()
        {
            if (Match(",") && Type() && Match("id") && InfArraySize()) {
                return true;
            }

            return false;
        }
    }
}
