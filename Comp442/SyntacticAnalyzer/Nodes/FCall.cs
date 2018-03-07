using SyntacticAnalyzer.Pattern;
using System;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class FCall : IVisitable
    {
        public string Id { get; set; }
        public AParams Parameters { get; set; }

        public void Accept(Visitor visitor)
        {
            visitor.Visit(this);
        }

        public override string ToString()
        {
            return $"{Id}({Parameters})";
        }
    }
}
