namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool ArraySize()
        {
            if (Match("[") && Match("intNum") && Match("]")) {
                this.ApplyDerivation("arraySize -> '[' 'intNum' ']'");
                return true;
            }

            return false;
        }
    }
}
