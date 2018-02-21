using System;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class VarDecl
    {
        public string Type { get; set; }
        public string Id { get; set; }
        public DimList Dimentions { get; set; }
    }
}
