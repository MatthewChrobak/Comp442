using System;
using System.Xml.Serialization;

namespace SyntacticAnalyzer.Nodes
{
    [XmlInclude(typeof(RelExpr))]
    [XmlInclude(typeof(ArithExpr))]
    [Serializable]
    public class ForStat
    {
        public string Type;
        public string Id;
        [XmlElement(type: typeof(RelExpr), DataType = "Real Expression")]
        [XmlElement(type: typeof(ArithExpr), DataType = "Arithmetic Expression")]
        public object Initialization;
        public RelExpr Condition;
        public AssignStat Update;
        public StatBlock LoopBlock;
    }
}
