using SyntacticAnalyzer.Semantics;
using System;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class GetStat : Node, IVisitable
    {
        public Var Variable { get; set; }

        // Just used for serialization.
        public GetStat() : base((-1, -1))
        {

        }

        public GetStat((int, int) location) : base(location)
        {
        }

        public void Accept(Visitor visitor)
        {
            this.Variable?.Accept(visitor);
            visitor.Visit(this);
        }

        public override string ToString()
        {
            return $"Get {Variable}";
        }
    }
}
