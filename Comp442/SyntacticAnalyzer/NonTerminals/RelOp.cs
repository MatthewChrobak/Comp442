using LexicalAnalyzer;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool RelOp()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = AtoCC.Convert(lookaheadToken);

            if ("eq".HasToken(lookahead)) {
                this.ApplyDerivation("relOp -> 'eq'");
                if (Match("eq")) {
                    return true;
                }
            }

            if ("neq".HasToken(lookahead)) {
                this.ApplyDerivation("relOp -> 'neq'");
                if (Match("neq")) {
                    return true;
                }
            }

            if ("lt".HasToken(lookahead)) {
                this.ApplyDerivation("relOp -> 'lt'");
                if (Match("lt")) {
                    return true;
                }
            }

            if ("gt".HasToken(lookahead)) {
                this.ApplyDerivation("relOp -> 'gt'");
                if (Match("gt")) {
                    return true;
                }
            }

            if ("leq".HasToken(lookahead)) {
                this.ApplyDerivation("relOp -> 'leq'");
                if (Match("leq")) {
                    return true;
                }
            }

            if ("geq".HasToken(lookahead)) {
                this.ApplyDerivation("relOp -> 'geq'");
                if (Match("geq")) {
                    return true;
                }
            }

            return false;
        }
    }
}
