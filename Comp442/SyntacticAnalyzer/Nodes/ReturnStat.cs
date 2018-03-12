using SyntacticAnalyzer.Semantics;
using System;
using System.Xml.Serialization;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class ReturnStat : Node, IVisitable
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
        public object ReturnValueExpression { get; set; } // resolves to expr

        public ReturnStat((int, int) location) : base(location)
        {
        }

        public void Accept(Visitor visitor)
        {
            if (this.ReturnValueExpression is IVisitable visitable) {
                visitable.Accept(visitor);
            }

            visitor.Visit(this);
        }

        public override string ToString()
        {
            return $"return {ReturnValueExpression}";
        }
    }
}
