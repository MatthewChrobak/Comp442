using System;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class ArithExpr
    {
        public ArithExpr LHS;
        public string Operator;
        public Term RHS;
    }
}
