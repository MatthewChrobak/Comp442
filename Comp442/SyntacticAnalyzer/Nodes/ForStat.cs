using System;
using System.Xml.Serialization;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class ForStat
    {
        public string Type;
        public string Id;
        public object Initialization;
        public RelExpr Condition;
        public AssignStat Update;
        public StatBlock LoopBlock;
    }
}
