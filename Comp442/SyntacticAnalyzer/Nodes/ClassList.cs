using SyntacticAnalyzer.Semantics;
using System;
using System.Collections.Generic;
using System.Xml.Serialization;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class ClassList : Node, IVisitable
    {
        [XmlElement("Class")]
        public List<ClassDecl> Classes { get; set; } = new List<ClassDecl>();

        public ClassList((int, int) location) : base(location)
        {
        }

        public void Accept(Visitor visitor)
        {
            visitor.PreVisit(this);

            foreach (var @class in this.Classes) {
                @class?.Accept(visitor);
            }

            visitor.Visit(this);
        }

        public override string ToString()
        {
            if (Classes?.Count > 0) {
                return String.Join("\n", Classes) + "\n";
            }
            return "\n";
        }
    }
}
