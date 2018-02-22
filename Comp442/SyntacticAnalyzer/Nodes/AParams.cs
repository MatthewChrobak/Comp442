using System;
using System.Collections.Generic;
using System.Xml.Serialization;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class AParams
    {
        public List<object> Expressions { get; set; } = new List<object>();
    }
}
