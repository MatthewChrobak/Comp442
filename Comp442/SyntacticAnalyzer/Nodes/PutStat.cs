using System;
using System.Xml.Serialization;

namespace SyntacticAnalyzer.Nodes
{
    [XmlInclude(typeof(RelExpr))]
    [XmlInclude(typeof(ArithExpr))]
    [Serializable]
    public class PutStat
    {
        [XmlElement(type: typeof(RelExpr), DataType = "Real Expression")]
        [XmlElement(type: typeof(ArithExpr), DataType = "Arithmetic Expression")]
        public object Expression;
    }
}
