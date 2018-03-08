using SyntacticAnalyzer.Semantics;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Xml.Serialization;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class FuncDefList : IVisitable
    {
        [XmlElement("Function")]
        public List<FuncDef> Functions { get; set; } = new List<FuncDef>();

        public void Accept(Visitor visitor)
        {
            foreach (var func in this.Functions) {
                func.Accept(visitor);
            }

            visitor.Visit(this);
        }

        public override string ToString()
        {
            if (Functions?.Count > 0) {
                return string.Join("\n", Functions.Select(val => val.ToString()));
            }
            return string.Empty;
        }
    }
}
