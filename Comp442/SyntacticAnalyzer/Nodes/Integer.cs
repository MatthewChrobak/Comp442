using SyntacticAnalyzer.Semantics;
using System;
using System.Xml.Serialization;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class Integer : Node, IVisitable
    {
        public string Value { set; get; }

        public Integer((int, int) location) : base(location)
        {
            this.SemanticalType = "int";
        }

        public void Accept(Visitor visitor)
        {
            visitor.Visit(this);
        }

        public override string ToString()
        {
            return this.Value;
        }
    }
}
