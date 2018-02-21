using System;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class MemDecl
    {
        public dynamic VariableOrFuncDecl { get; set; }
    }
}
