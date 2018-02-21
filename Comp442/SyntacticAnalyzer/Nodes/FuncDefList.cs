using System;
using System.Collections.Generic;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class FuncDefList
    {
        public List<FuncDef> Functions { get; set; } = new List<FuncDef>();
    }
}
