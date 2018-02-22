using System;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class AddOp
    {
        public object LHS_Term { get; set; }
        public string Operator { get; set; }
        public object RHS_ArithExpr { get; set; }
    }
}
