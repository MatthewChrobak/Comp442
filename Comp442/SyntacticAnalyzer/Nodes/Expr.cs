using System;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class Expr
    {
        public RelExpr Real;
        public ArithExpr Arith;
    }
}
