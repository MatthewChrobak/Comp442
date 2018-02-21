using System;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class Prog
    {
        public ClassList Classes { get; set; } = new ClassList();
        public FuncDefList Functions { get; set; } = new FuncDefList();
        public StatBlock Program { get; set; } = new StatBlock();
    }
}
