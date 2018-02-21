using System;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class FuncDef
    {
        public string ReturnType { get; set; }
        public ScopeSpec ScopeResolution { get; set; }
        public string FunctionName { get; set; }
        public FParamList Parameters { get; set; }
        public StatBlock Implementation { get; set; }
    }
}
