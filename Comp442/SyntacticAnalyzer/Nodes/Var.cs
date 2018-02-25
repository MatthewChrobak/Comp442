using System;
using System.Collections.Generic;
using System.Xml.Serialization;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class Var
    {
        [XmlArrayItem(type:typeof(DataMember), elementName:"DataMember")]
        [XmlArrayItem(type:typeof(FCall), elementName:"FunctionCall")]
        public List<object> Elements { get; set; } = new List<object>();

        public override string ToString()
        {
            if (Elements?.Count > 0) {
                return String.Join(".", Elements);
            }
            return string.Empty;
        }
    }
}
