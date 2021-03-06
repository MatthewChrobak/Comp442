﻿using SyntacticAnalyzer.Semantics;
using System;
using System.Xml.Serialization;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class AssignStat : Node, IVisitable
    {
        public Var Variable { get; set; }

        [XmlElement(type: typeof(AddOp), elementName: "AddOp")] // arithExpr
        [XmlElement(type: typeof(RelExpr), elementName: "RelationalExpression")] // expr
        [XmlElement(type: typeof(MultOp), elementName: "MultOp")] // term
        [XmlElement(type: typeof(Var), elementName: "OtherVariable")] // factor
        [XmlElement(type: typeof(Integer), elementName: "Integer")] // factor
        [XmlElement(type: typeof(Float), elementName: "Float")] // factor
        [XmlElement(type: typeof(FCall), elementName: "FunctionCall")] // factor
        [XmlElement(type: typeof(Not), elementName: "NotFactor")] // factor
        [XmlElement(type: typeof(Sign), elementName: "SignFactor")] // factor
        public Node ExpressionValue { get; set; } // resolves to expr

        // Just used for serialization.
        public AssignStat() : base((-1, -1))
        {

        }

        public AssignStat((int, int) location) : base(location)
        {
        }

        public void Accept(Visitor visitor)
        {
            this.Variable?.Accept(visitor);
            if (this.ExpressionValue is IVisitable expressionValue) {
                expressionValue?.Accept(visitor);
            }
            visitor.Visit(this);
        }

        public override string ToString()
        {
            return $"{Variable}={ExpressionValue}";
        }
    }
}
