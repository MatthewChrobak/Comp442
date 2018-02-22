using System;
using System.Collections.Generic;
using System.Xml.Serialization;

namespace SyntacticAnalyzer.Nodes
{
    [XmlInclude(typeof(VarDecl))]
    [XmlInclude(typeof(AssignStat))]
    [XmlInclude(typeof(IfStat))]
    [XmlInclude(typeof(GetStat))]
    [XmlInclude(typeof(PutStat))]
    [XmlInclude(typeof(ReturnStat))]
    [Serializable]
    public class StatBlock
    {
        [XmlArray("Statements")]
        [XmlArrayItem("Variable Declaration", type: typeof(VarDecl))]
        [XmlArrayItem("Assignment Statement", type: typeof(AssignStat))]
        [XmlArrayItem("If Statment", type: typeof(IfStat))]
        [XmlArrayItem("Get Statement", type: typeof(GetStat))]
        [XmlArrayItem("Put Statement", type: typeof(PutStat))]
        [XmlArrayItem("Return Statement", type: typeof(ReturnStat))]
        public List<object> Statements { get; set; } = new List<object>();
    }
}
