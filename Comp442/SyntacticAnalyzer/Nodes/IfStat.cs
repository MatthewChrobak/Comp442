using System;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class IfStat
    {
        public RelExpr Condition { get; set; }
        public StatBlock TrueBlock { get; set; }
        public StatBlock ElseBlock { get; set; }
    }
}
