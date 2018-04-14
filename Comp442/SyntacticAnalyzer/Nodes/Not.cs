using SyntacticAnalyzer.Semantics;
using System;
using System.Xml.Serialization;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class Not : Node, IVisitable
    {
        [XmlElement(type: typeof(AddOp), elementName: "AddOp")] // arithExpr
        [XmlElement(type: typeof(RelExpr), elementName: "RelationalExpression")] // expr
        [XmlElement(type: typeof(MultOp), elementName: "MultOp")] // term
        [XmlElement(type: typeof(Var), elementName: "Variable")] // factor
        [XmlElement(type: typeof(Integer), elementName: "Integer")] // factor
        [XmlElement(type: typeof(Float), elementName: "Float")] // factor
        [XmlElement(type: typeof(FCall), elementName: "FunctionCall")] // factor
        [XmlElement(type: typeof(Not), elementName: "NotFactor")] // factor
        [XmlElement(type: typeof(Sign), elementName: "SignFactor")] // factor
        public Node Factor { get; set; } // factor

        // Just used for serialization.
        public Not() : base((-1, -1))
        {

        }

        public Not((int, int) location) : base(location)
        {
            this.IsLiteral = true;
        }

        public void Accept(Visitor visitor)
        {
            if (this.Factor is IVisitable factor) {
                factor?.Accept(visitor);
            }

            visitor.Visit(this);
        }

        public override string ToString()
        {
            return $"(not {Factor})";
        }
    }
}
