using SyntacticAnalyzer.Semantics;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Xml.Serialization;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class FuncDefList : Node, IVisitable
    {
        [XmlElement("Function")]
        public List<FuncDef> Functions { get; set; } = new List<FuncDef>();

        public FuncDefList((int, int) location) : base(location)
        {
        }

        public void Accept(Visitor visitor)
        {
            foreach (var func in this.Functions) {
                func.Accept(visitor);
            }

            visitor.Visit(this);
        }

        public override string ToString()
        {
            if (this.Functions?.Count > 0) {
                return String.Join("\n", this.Functions.Select(val => val.ToString()));
            }
            return string.Empty;
        }
    }
}
