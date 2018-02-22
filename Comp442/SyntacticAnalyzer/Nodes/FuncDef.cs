using System;
using System.Collections.Generic;
using System.Xml.Serialization;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class FuncDef
    {
        public string ReturnType { get; set; }
        public ScopeSpec ScopeResolution { get; set; }
        public string FunctionName { get; set; }

        [XmlArray("Parameters")]
        [XmlArrayItem("Parameter")]
        public List<FParam> Parameters { get; set; } = new List<FParam>();
        public StatBlock Implementation { get; set; }
    }
}
