using System;
using System.Collections.Generic;
using System.Xml.Serialization;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class FuncDecl
    {
        public string Type { get; set; }
        public string Id { get; set; }

        [XmlArray("Parameters")]
        [XmlArrayItem("Parameter")]
        public List<FParam> Parameters { get; set; } = new List<FParam>();
    }
}
