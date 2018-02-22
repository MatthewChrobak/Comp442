using System;
using System.Xml.Serialization;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class Sign
    {
        public string SignSymbol { get; set; }
        public object Factor { get; set; }
    }
}
