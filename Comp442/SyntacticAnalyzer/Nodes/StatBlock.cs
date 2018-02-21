using System.Collections.Generic;

namespace SyntacticAnalyzer.Nodes
{
    public class StatBlock
    {
        public List<StatOrVarDecl> Statements { get; set; } = new List<StatOrVarDecl>();
    }
}
