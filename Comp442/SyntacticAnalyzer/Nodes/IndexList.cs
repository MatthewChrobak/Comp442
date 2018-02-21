using System;
using System.Collections.Generic;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class IndexList
    {
        public List<ArithExpr> Expressions { get; set; } = new List<ArithExpr>();
    }
}
