using System;
using System.Xml.Serialization;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class RelExpr
    {
        public object LHS { get; set; }

        public string RelationOperator { get; set; }
        
        public object RHS { get; set; }
    }
}
