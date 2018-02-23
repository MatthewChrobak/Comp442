using System;
using System.Xml.Serialization;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class RelExpr
    {
        [XmlElement(type:typeof(AddOp), elementName: "LeftAdLeftdOp")] // arithExpr
        [XmlElement(type: typeof(MultOp), elementName: "LeftMultOp")] // term
        [XmlElement(type: typeof(Var), elementName: "LeftVariable")] // factor
        [XmlElement(type: typeof(string), elementName: "LeftNumber")] // factor
        [XmlElement(type: typeof(FCall), elementName: "LeftFunctionCall")] // factor
        [XmlElement(type: typeof(Not), elementName: "LeftNotFactor")] // factor
        [XmlElement(type: typeof(Sign), elementName: "LeftSignFactor")] // factor
        public object LHS { get; set; } // arithExpr

        public string RelationOperator { get; set; }

        [XmlElement(type: typeof(AddOp), elementName: "RightAddOp")] // arithExpr
        [XmlElement(type: typeof(MultOp), elementName: "RightMultOp")] // term
        [XmlElement(type: typeof(Var), elementName: "RightVariable")] // factor
        [XmlElement(type: typeof(string), elementName: "RightNumber")] // factor
        [XmlElement(type: typeof(FCall), elementName: "RightFunctionCall")] // factor
        [XmlElement(type: typeof(Not), elementName: "RightNotFactor")] // factor
        [XmlElement(type: typeof(Sign), elementName: "RightSignFactor")] // factor
        public object RHS { get; set; } // arithExpr
    }
}
