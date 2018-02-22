using System;
using System.Collections.Generic;
using System.Xml.Serialization;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class StatBlock
    {
        public List<object> Statements { get; set; } = new List<object>();
    }
}
