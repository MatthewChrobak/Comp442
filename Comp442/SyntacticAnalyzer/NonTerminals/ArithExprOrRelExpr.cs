﻿using SyntacticAnalyzer.Nodes;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        // Decides whether or not it's a relExpr or arithExpr.
        private object ArithExprOrRelExpr(object givenArithExpr)
        {
            string first = "eq neq lt gt leq geq";
            string follow = ") ; ,";
            this.SkipErrors(first, follow);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("arithExprOrRelExpr -> relOp arithExpr");

                var relExpr = new RelExpr();

                string relationalOperator = RelOp();
                var arithExpr = ArithExpr();

                relExpr.LHS = givenArithExpr;
                relExpr.RelationOperator = relationalOperator;
                relExpr.RHS = arithExpr;

                return relExpr;
            }

            if (follow.HasToken(lookahead)) {
                this.ApplyDerivation("arithExprOrRelExpr -> EPSILON");
                return givenArithExpr;
            }

            return null;
        }
    }
}
