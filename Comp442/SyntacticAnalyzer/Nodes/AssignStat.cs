using System;
using System.Xml.Serialization;

namespace SyntacticAnalyzer.Nodes
{
    [XmlInclude(typeof(RelExpr))]
    [XmlInclude(typeof(ArithExpr))]
    [Serializable]
    public class AssignStat
    {
        public Var Variable { get; set; }

        [XmlElement(type: typeof(RelExpr), DataType = "Real Expression")]
        [XmlElement(type: typeof(ArithExpr), DataType = "Arithmetic Expression")]
        public object ExpressionValue { get; set; }
    }
}
