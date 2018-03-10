using SyntacticAnalyzer.Semantics;
using System;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class GetStat : Node, IVisitable
    {
        public Var Variable { get; set; }

        public void Accept(Visitor visitor)
        {
            visitor.Visit(this);
        }

        public override string ToString()
        {
            return $"Get {Variable}";
        }
    }
}
