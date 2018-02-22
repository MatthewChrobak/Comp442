using System;
using System.Collections.Generic;
using System.Xml.Serialization;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class FuncDefList
    {
        [XmlElement("Function")]
        public List<FuncDef> Functions { get; set; } = new List<FuncDef>();
    }
}
