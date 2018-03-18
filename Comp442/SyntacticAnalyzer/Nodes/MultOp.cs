using SyntacticAnalyzer.Semantics;
using System;
using System.Xml.Serialization;

namespace SyntacticAnalyzer.Nodes
{
    // TODO: XmlInclude all of that in Factor
    [Serializable]
    public class MultOp : Node, IVisitable
    {
        [XmlElement(type: typeof(AddOp), elementName: "LeftAddOp")] // arithExpr
        [XmlElement(type: typeof(RelExpr), elementName: "LeftRelationalExpression")] // expr
        [XmlElement(type: typeof(MultOp), elementName: "LeftMultOp")] // term
        [XmlElement(type: typeof(Var), elementName: "LeftVariable")] // factor
        [XmlElement(type: typeof(Integer), elementName: "LeftInteger")] // factor
        [XmlElement(type: typeof(Float), elementName: "LeftFloat")] // factor
        [XmlElement(type: typeof(FCall), elementName: "LeftFunctionCall")] // factor
        [XmlElement(type: typeof(Not), elementName: "LeftNotFactor")] // factor
        [XmlElement(type: typeof(Sign), elementName: "LeftSignFactor")] // factor
        public object LHS { get; set; } // factor

        public string Operator { get; set; }

        [XmlElement(type: typeof(AddOp), elementName: "RightAddOp")] // arithExpr
        [XmlElement(type: typeof(RelExpr), elementName: "RightRelationalExpression")] // expr
        [XmlElement(type: typeof(MultOp), elementName: "RightMultOp")] // term
        [XmlElement(type: typeof(Var), elementName: "RightVariable")] // factor
        [XmlElement(type: typeof(Integer), elementName: "RightInteger")] // factor
        [XmlElement(type: typeof(Float), elementName: "RightFloat")] // factor
        [XmlElement(type: typeof(FCall), elementName: "RightFunctionCall")] // factor
        [XmlElement(type: typeof(Not), elementName: "RightNotFactor")] // factor
        [XmlElement(type: typeof(Sign), elementName: "RightSignFactor")] // factor
        public object RHS { get; set; } // factor

        public MultOp((int, int) location) : base(location)
        {
        }

        public void Accept(Visitor visitor)
        {
            if (this.LHS is IVisitable lhs) {
                lhs?.Accept(visitor);
            }

            if (this.RHS is IVisitable rhs) {
                rhs?.Accept(visitor);
            }

            visitor.Visit(this);
        }

        public override string ToString()
        {
            return $"({LHS} {Operator} {RHS})";
        }
    }
}
