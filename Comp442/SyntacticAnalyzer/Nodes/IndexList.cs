using System;
using System.Collections.Generic;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class IndexList
    {
        public List<object> Expressions { get; set; } = new List<object>();
    }
}
