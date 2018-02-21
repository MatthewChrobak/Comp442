using System.Collections.Generic;

namespace SyntacticAnalyzer.Nodes
{
    public class Var
    {
        public List<VarElement> Elements { get; set; } = new List<VarElement>();
    }
}
