using System;
using System.Collections.Generic;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class FParam
    {
        public string Type { get; set; }
        public string Id { get; set; }
        public List<string> Dimensions { get; set; } = new List<string>();
    }
}
