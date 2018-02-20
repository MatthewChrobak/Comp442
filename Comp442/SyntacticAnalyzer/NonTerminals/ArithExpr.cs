namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool ArithExpr()
        {
            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if ("intNum floatNum ( not id + -".HasToken(lookahead)) {
                this.ApplyDerivation("arithExpr -> term arithExprP");
                if (Term() && ArithExprP()) {
                    return true;
                }
            }

            return false;
        }
    }
}
