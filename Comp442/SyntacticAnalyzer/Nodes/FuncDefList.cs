using System;
using System.Collections.Generic;
using System.Linq;
using System.Xml.Serialization;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class FuncDefList
    {
        [XmlElement("Function")]
        public List<FuncDef> Functions { get; set; } = new List<FuncDef>();

        public override string ToString()
        {
            return string.Join("\n", Functions.Select(val => val.ToString()));
        }
    }
}
