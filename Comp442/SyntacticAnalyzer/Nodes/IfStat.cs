namespace SyntacticAnalyzer.Nodes
{
    public class IfStat
    {
        public RelExpr Condition { get; set; }
        public StatBlock TrueBlock { get; set; }
        public StatBlock ElseBlock { get; set; }
    }
}
