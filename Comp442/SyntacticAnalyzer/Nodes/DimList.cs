using System;
using System.Collections.Generic;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class DimList
    {
        public List<string> Numbers { get; set; } = new List<string>();
    }
}
