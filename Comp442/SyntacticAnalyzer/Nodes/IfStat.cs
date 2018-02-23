using System;
using System.Xml.Serialization;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class IfStat
    {
        [XmlElement(type: typeof(AddOp), elementName: "AddOp")] // arithExpr
        [XmlElement(type: typeof(RelExpr), elementName: "RelationalExpression")] // expr
        [XmlElement(type: typeof(MultOp), elementName: "MultOp")] // term
        [XmlElement(type: typeof(Var), elementName: "Variable")] // factor
        [XmlElement(type: typeof(string), elementName: "Number")] // factor
        [XmlElement(type: typeof(FCall), elementName: "FunctionCall")] // factor
        [XmlElement(type: typeof(Not), elementName: "NotFactor")] // factor
        [XmlElement(type: typeof(Sign), elementName: "SignFactor")] // factor
        public object Condition { get; set; }
        public StatBlock TrueBlock { get; set; }
        public StatBlock ElseBlock { get; set; }
    }
}
