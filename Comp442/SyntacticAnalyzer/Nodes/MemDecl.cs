namespace SyntacticAnalyzer.Nodes
{
    public abstract class MemDecl
    {

    }

    public class VarDecl : MemDecl
    {

    }

    public class FuncDecl : MemDecl
    {
        public string Type { get; set; }
        public string Id { get; set; }
        public FParamList Parameters { get; set; }
    }
}
