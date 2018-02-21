using System;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class RelExpr
    {
        public Expr LHS;
        public string RelationOperator;
        public Expr RHS;
    }
}
