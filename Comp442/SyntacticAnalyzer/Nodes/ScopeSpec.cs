using SyntacticAnalyzer.Semantics;
using System;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class ScopeSpec : Node, IVisitable
    {
        public string ID { get; set; }

        // Just used for serialization.
        public ScopeSpec() : base((-1, -1))
        {

        }

        public ScopeSpec((int, int) location) : base(location)
        {
        }

        public void Accept(Visitor visitor)
        {
            visitor.Visit(this);
        }

        public override string ToString()
        {
            return $"{ID}::";
        }
    }
}
