using System;
using System.Collections.Generic;
using System.Xml.Serialization;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class ClassList
    {
        [XmlElement("Class")]
        public List<ClassDecl> Classes { get; set; } = new List<ClassDecl>();

        public override string ToString()
        {
            if (Classes?.Count > 0) {
                return String.Join("\n", Classes) + "\n";
            }
            return "\n";
        }
    }
}
