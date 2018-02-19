namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool Indice()
        {
            if (Match("[") && ArithExpr() && Match("]")) {
                return true;
            }

            return false;
        }
    }
}
