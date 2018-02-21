using System.Collections.Generic;

namespace SyntacticAnalyzer.Nodes
{
    public class MembList
    {
        public List<MemDecl> Members { get; set; } = new List<MemDecl>();
    }
}
