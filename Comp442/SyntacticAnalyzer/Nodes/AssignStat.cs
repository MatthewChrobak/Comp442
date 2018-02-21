using System;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class AssignStat
    {
        public Var Variable;
        public Expr ExpressionValue;
    }
}
