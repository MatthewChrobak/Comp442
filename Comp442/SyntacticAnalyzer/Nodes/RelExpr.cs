using System;
using System.Xml.Serialization;

namespace SyntacticAnalyzer.Nodes
{
    [XmlInclude(typeof(RelExpr))]
    [XmlInclude(typeof(ArithExpr))]
    [Serializable]
    public class RelExpr
    {
        [XmlElement(type: typeof(RelExpr), DataType = "LHS: Real Expression")]
        [XmlElement(type: typeof(ArithExpr), DataType = "LHS: Arithmetic Expression")]
        public object LHS;

        public string RelationOperator;

        [XmlElement(type: typeof(RelExpr), DataType = "RHS: Real Expression")]
        [XmlElement(type: typeof(ArithExpr), DataType = "RHS: Arithmetic Expression")]
        public object RHS;
    }
}
