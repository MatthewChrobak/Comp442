using System;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class FParam
    {
        public string Type { get; set; }
        public string Id { get; set; }
        public DimList Dimentions { get; set; }
    }
}
