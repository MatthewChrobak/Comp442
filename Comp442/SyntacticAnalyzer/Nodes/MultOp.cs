using System;
using System.Xml.Serialization;

namespace SyntacticAnalyzer.Nodes
{
    // TODO: XmlInclude all of that in Factor
    [Serializable]
    public class MultOp
    {
        public object RHS_Term { get; set; }
        public string Operator { get; set; }
        public object LHS_Factor { get; set; }
    }
}
