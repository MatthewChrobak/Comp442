using System;
using System.Collections.Generic;
using System.Xml.Serialization;

namespace SyntacticAnalyzer.Nodes
{
    [XmlInclude(typeof(DataMember))]
    [XmlInclude(typeof(FCall))]
    [Serializable]
    public class Var
    {
        [XmlArray("Variable Elements")]
        [XmlArrayItem("Data Member", type: typeof(DataMember))]
        [XmlArrayItem("Function Call", type: typeof(FCall))]
        public List<object> Elements { get; set; } = new List<object>();
    }
}
