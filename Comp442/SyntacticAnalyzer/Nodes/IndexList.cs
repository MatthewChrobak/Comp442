using System.Collections.Generic;

namespace SyntacticAnalyzer.Nodes
{
    public class IndexList
    {
        public List<ArithExpr> Expressions { get; set; } = new List<ArithExpr>();
    }
}
