using System;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class StatOrVarDecl
    {
        public dynamic StatOrVariableDeclaration { get; set; }
    }
}
