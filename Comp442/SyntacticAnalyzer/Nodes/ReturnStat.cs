using System;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class ReturnStat
    {
        public Expr ReturnValueExpression;
    }
}
