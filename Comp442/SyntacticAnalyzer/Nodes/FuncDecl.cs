namespace SyntacticAnalyzer.Nodes
{
    public class FuncDecl
    {
        public string Type { get; set; }
        public string Id { get; set; }
        public FParamList Parameters { get; set; }
    }
}
