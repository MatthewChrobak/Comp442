namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool TermP()
        {
            string first = "* / and";
            string follow = "+ - or eq neq lt gt leq geq ] ) ; ,";
            this.SkipErrors(first, follow);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("termP -> multOp factor termP");

                MultOp();
                Factor();
                TermP();
            }

            if (follow.HasToken(lookahead)) {
                this.ApplyDerivation("termP -> EPSILON");
                return true;
            }

            return false;
        }
    }
}
