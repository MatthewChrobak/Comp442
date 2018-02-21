using System;
using System.Collections.Generic;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class StatBlock
    {
        public List<StatOrVarDecl> Statements { get; set; } = new List<StatOrVarDecl>();
    }
}
