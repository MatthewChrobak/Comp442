using System;
using System.Collections.Generic;
using System.Xml.Serialization;

namespace SyntacticAnalyzer.Nodes
{
    [XmlInclude(typeof(VarDecl))]
    [Serializable]
    public class MembList
    {
        [XmlElement("Member")]
        public List<object> Members { get; set; } = new List<object>();
    }
}
