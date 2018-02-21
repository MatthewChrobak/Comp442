using System;
using System.Collections.Generic;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class MembList
    {
        public List<MemDecl> Members { get; set; } = new List<MemDecl>();
    }
}
