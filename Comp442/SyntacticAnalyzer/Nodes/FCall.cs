using SyntacticAnalyzer.Semantics;
using System;
using System.Xml.Serialization;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class FCall : Node, IVisitable
    {
        public string Id { get; set; }
        public AParams Parameters { get; set; }

        public FCall((int, int) location) : base(location)
        {

        }

        public void Accept(Visitor visitor)
        {
            visitor.PreVisit(this);
            this.Parameters?.Accept(visitor);
            visitor.Visit(this);
        }

        public override string ToString()
        {
            return $"{Id}({Parameters})";
        }
    }
}
