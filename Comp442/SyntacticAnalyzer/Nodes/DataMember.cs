using SyntacticAnalyzer.Semantics;
using System;
using System.Xml.Serialization;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class DataMember : Node, IVisitable
    {
        public string Id { get; set; }
        public IndexList Indexes { get; set; }

        [XmlIgnore]
        public int baseOffset { get; set; }
        [XmlIgnore]
        public int NonArrayTypeMemorySize { get; set; }

        public DataMember((int, int) location) : base(location)
        {
        }

        public void Accept(Visitor visitor)
        {
            this.Indexes?.Accept(visitor);
            visitor.Visit(this);
        }

        public override string ToString()
        {
            return Id + Indexes;
        }
    }
}
