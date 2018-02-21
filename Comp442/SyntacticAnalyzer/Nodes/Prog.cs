using System;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class Prog
    {
        public ClassListNode InfClasses { get; set; }
        public FuncDefList Functions { get; set; }
        public StatBlock Program { get; set; }
    }
}
