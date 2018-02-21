namespace SyntacticAnalyzer.Nodes
{
    public class Prog
    {
        public ClassList Classes { get; set; }
        public FuncDefList Functions { get; set; }
        public StatBlock Program { get; set; }
    }
}
