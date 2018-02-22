using System;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class Program
    {
        public ClassList Classes { get; set; }
        public FuncDefList Functions { get; set; }
        public StatBlock MainFunction { get; set; }
    }
}
