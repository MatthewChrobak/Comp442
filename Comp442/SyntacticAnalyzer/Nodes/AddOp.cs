using System;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class AddOp
    {
        public ArithExpr LHS { get; set; }
        public string Operator { get; set; }
        public Term RHS { get; set; }
    }
}
