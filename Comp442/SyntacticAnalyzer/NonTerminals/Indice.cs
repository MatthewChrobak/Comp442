namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool Indice()
        {
            this.ApplyDerivation("indice -> '[' arithExpr ']'");

            if (Match("[") && ArithExpr() && Match("]")) {
                return true;
            }

            return false;
        }
    }
}
