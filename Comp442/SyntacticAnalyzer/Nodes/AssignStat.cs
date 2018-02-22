using System;
using System.Xml.Serialization;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class AssignStat
    {
        public Var Variable { get; set; }
        
        public object ExpressionValue { get; set; }
    }
}
