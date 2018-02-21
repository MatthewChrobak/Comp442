namespace SyntacticAnalyzer.Nodes
{
    public class ForStat
    {
        public string Type;
        public string Id;
        public Expr Initialization;
        public RelExpr Condition;
        public AssignStat Update;
        public StatBlock LoopBlock;
    }
}
