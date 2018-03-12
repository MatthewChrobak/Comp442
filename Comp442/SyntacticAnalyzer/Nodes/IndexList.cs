using SyntacticAnalyzer.Semantics;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Xml.Serialization;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class IndexList : Node, IVisitable
    {
        [XmlArrayItem(type: typeof(AddOp), elementName: "AddOp")] // arithExpr
        [XmlArrayItem(type: typeof(RelExpr), elementName: "RelationalExpression")] // expr
        [XmlArrayItem(type: typeof(MultOp), elementName: "MultOp")] // term
        [XmlArrayItem(type: typeof(Var), elementName: "Variable")] // factor
        [XmlElement(type: typeof(Integer), elementName: "Integer")] // factor
        [XmlElement(type: typeof(Float), elementName: "Float")] // factor
        [XmlArrayItem(type: typeof(FCall), elementName: "FunctionCall")] // factor
        [XmlArrayItem(type: typeof(Not), elementName: "NotFactor")] // factor
        [XmlArrayItem(type: typeof(Sign), elementName: "SignFactor")] // factor
        public List<object> Expressions { get; set; } = new List<object>();

        public IndexList((int, int) location) : base(location)
        {
        }

        public void Accept(Visitor visitor)
        {
            foreach (var expression in this.Expressions) {
                if (expression is IVisitable visitable) {
                    visitable.Accept(visitor);
                }
            }

            visitor.Visit(this);
        }

        public override string ToString()
        {
            if (Expressions?.Count > 0) {
                return String.Join(string.Empty, Expressions.Select(val => $"[{val}]"));
            }
            return string.Empty;
        }
    }
}
