using System;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class Not
    {
        public Factor Factor { get; set; }
    }
}
