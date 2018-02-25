using System;
using System.Collections.Generic;
using System.Linq;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class VarDecl
    {
        public string Type { get; set; }
        public string Id { get; set; }
        public List<string> Dimensions { get; set; } = new List<string>();

        public override string ToString()
        {
            if (Dimensions?.Count > 0) {
                return $"{Type} {Id}{String.Join(string.Empty, Dimensions.Select(val => $"[{val}]"))}";
            }
            return $"{Type} {Id}";
        }
    }
}
