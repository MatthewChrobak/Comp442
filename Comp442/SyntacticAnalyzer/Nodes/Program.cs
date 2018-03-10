using System;
using System.Xml.Serialization;
using SyntacticAnalyzer.Semantics;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class Program : Node, IVisitable
    {
        public ClassList Classes { get; set; }
        public FuncDefList Functions { get; set; }
        public StatBlock MainFunction { get; set; }

        [XmlIgnore]
        public SymbolTable Table { get; set; }

        public void Accept(Visitor visitor)
        {
            this.Classes.Accept(visitor);
            this.Functions.Accept(visitor);
            this.MainFunction.Accept(visitor);

            visitor.Visit(this);
        }

        public override string ToString()
        {
            return $"{Classes}{Functions}\nprogram{MainFunction};";
        }
    }
}
