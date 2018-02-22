using System;
using System.Collections.Generic;
using System.Xml.Serialization;

namespace SyntacticAnalyzer.Nodes
{
    [XmlInclude(typeof(RelExpr))]
    [XmlInclude(typeof(ArithExpr))]
    [Serializable]
    public class AParams
    {
        [XmlArray("Expressions")]
        [XmlArrayItem(type: typeof(RelExpr), DataType = "Real Expression")]
        [XmlArrayItem(type: typeof(ArithExpr), DataType = "Arithmetic Expression")]
        public List<object> Expressions { get; set; }
    }
}
