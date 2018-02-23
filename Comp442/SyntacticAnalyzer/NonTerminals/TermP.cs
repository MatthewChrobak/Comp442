using SyntacticAnalyzer.Nodes;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        // This should make a decision between
        // MultOp or Factor
        private object TermP(object factor)
        {
            string first = "* / and";
            string follow = "+ - or eq neq lt gt leq geq ] ) ; ,";
            this.SkipErrors(first, follow);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("termP -> multOp factor termP");

                var term = new MultOp();
                
                string op = MultOp();
                object nextTerm = Factor();
                object trailingTerm = TermP(nextTerm);

                term.LHS = factor;
                term.Operator = op;
                term.RHS = trailingTerm;

                return term;
            }

            if (follow.HasToken(lookahead)) {
                this.ApplyDerivation("termP -> EPSILON");
                return factor;
            }

            return null;
        }
    }
}
