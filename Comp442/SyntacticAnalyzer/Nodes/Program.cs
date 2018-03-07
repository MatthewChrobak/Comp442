using System;
using SyntacticAnalyzer.Pattern;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class Program : IVisitable
    {
        public ClassList Classes { get; set; }
        public FuncDefList Functions { get; set; }
        public StatBlock MainFunction { get; set; }

        public void Accept(Visitor visitor)
        {
            visitor.Visit(this);
        }

        public override string ToString()
        {
            return $"{Classes}{Functions}\nprogram{MainFunction};";
        }
    }
}
