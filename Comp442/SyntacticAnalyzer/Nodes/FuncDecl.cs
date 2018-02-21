using System;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class FuncDecl
    {
        public string Type { get; set; }
        public string Id { get; set; }
        public FParamList Parameters { get; set; }
    }
}
