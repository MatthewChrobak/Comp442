using System;
using System.Collections.Generic;
using System.Xml.Serialization;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class Var
    {
        public List<object> Elements { get; set; } = new List<object>();
    }
}
