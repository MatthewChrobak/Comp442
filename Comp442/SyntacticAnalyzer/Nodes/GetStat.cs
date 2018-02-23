using System;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class GetStat
    {
        public Var Variable { get; set; }
    }
}
