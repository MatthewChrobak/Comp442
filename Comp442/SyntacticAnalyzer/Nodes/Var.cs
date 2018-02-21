using System;
using System.Collections.Generic;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class Var
    {
        public List<VarElement> Elements { get; set; } = new List<VarElement>();
    }
}
