using System;
using System.Xml.Serialization;

namespace SyntacticAnalyzer.Nodes
{
    [XmlInclude(typeof(RelExpr))]
    [XmlInclude(typeof(ArithExpr))]
    [Serializable]
    public class ReturnStat
    {
        [XmlElement(type: typeof(RelExpr), DataType = "Return Real Expression")]
        [XmlElement(type: typeof(ArithExpr), DataType = "Return Arithmetic Expression")]
        public object ReturnValueExpression;
    }
}
