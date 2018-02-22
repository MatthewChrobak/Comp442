using System;
using System.Xml.Serialization;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class Not
    {
        public object Factor { get; set; }
    }
}
