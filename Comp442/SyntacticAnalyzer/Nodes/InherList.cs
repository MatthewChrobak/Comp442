using System;
using System.Collections.Generic;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class InherList
    {
        public List<string> IDs { get; set; } = new List<string>();
    }
}
