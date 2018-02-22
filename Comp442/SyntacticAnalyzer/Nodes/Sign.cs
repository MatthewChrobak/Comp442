using System;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class Sign
    {
        public string SignSymbol { get; set; }
        public Factor Factor { get; set; }
    }
}
