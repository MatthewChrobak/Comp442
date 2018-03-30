using SyntacticAnalyzer.Semantics;
using System;
using System.Xml.Serialization;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class Float : Node, IVisitable
    {
        public string Value { get; set; }

        public Float((int, int) location) : base(location)
        {
            this.SemanticalType = "float";
            this.IsLiteral = true;
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
