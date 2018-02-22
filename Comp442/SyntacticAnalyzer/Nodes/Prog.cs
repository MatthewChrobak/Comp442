using System;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class Prog
    {
        public ClassList Classes { get; set; }
        public FuncDefList Functions { get; set; }
        public StatBlock Program { get; set; }
    }
}
