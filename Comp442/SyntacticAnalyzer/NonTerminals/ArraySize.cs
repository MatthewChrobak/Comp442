namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool ArraySize()
        {
            if (Match("[") && Match("intNum") && Match("]")) {
                return true;
            }

            return false;
        }
    }
}
