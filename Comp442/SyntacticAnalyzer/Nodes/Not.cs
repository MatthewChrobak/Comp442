using System;
using System.Xml.Serialization;

namespace SyntacticAnalyzer.Nodes
{
    [XmlInclude(typeof(Var))]
    [XmlInclude(typeof(string))]
    [XmlInclude(typeof(FCall))]
    [XmlInclude(typeof(ArithExpr))]
    [XmlInclude(typeof(Not))]
    [XmlInclude(typeof(Sign))]
    [Serializable]
    public class Not
    {
        [XmlElement(type: typeof(Var), DataType = "Variable")]
        [XmlElement(type: typeof(string), DataType = "Number")]
        [XmlElement(type: typeof(FCall), DataType = "Function Call")]
        [XmlElement(type: typeof(ArithExpr), DataType = "Arithmetic Expression")]
        [XmlElement(type: typeof(Not), DataType = "Not")]
        [XmlElement(type: typeof(Sign), DataType = "Sign")]
        public object Factor { get; set; }
    }
}
