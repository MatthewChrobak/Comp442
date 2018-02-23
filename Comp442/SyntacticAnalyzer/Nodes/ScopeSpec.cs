using System;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class ScopeSpec
    {
        public string Id { get; set; }

        public override string ToString()
        {
            return $"{Id}::";
        }
    }
}
