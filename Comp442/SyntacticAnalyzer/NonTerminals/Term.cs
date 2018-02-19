namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool Term()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if ("intNum floatNum ( not id + -".HasToken(lookahead)) {
                this.ApplyDerivation("term -> factor termP");
                if (Factor() && TermP()) {
                    return true;
                }
            }

            return false;
        }
    }
}
