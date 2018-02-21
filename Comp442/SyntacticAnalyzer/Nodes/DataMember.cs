using System;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class DataMember
    {
        public string Id { get; set; }
        public IndexList Indexes { get; set; }
    }
}
