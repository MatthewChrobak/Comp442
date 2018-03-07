using SyntacticAnalyzer.Pattern;
using System;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class DataMember : IVisitable
    {
        public string Id { get; set; }
        public IndexList Indexes { get; set; }

        public void Accept(Visitor visitor)
        {
            visitor.Visit(this);
        }

        public override string ToString()
        {
            return Id + Indexes;
        }
    }
}
