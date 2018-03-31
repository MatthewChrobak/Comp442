using System.Xml.Serialization;

namespace SyntacticAnalyzer.Nodes
{
    public class Node
    {
        [XmlIgnore]
        public (int line, int column) Location { get; private set; }

        [XmlIgnore]
        public int NodeMemorySize { get; set; } = 0;

        [XmlIgnore]
        public string SemanticalType { get; set; } = "null";

        [XmlIgnore]
        public int stackOffset { get; set; } = -32000; // This won't always be used.

        [XmlIgnore]
        public bool IsLiteral { get; set; } = false;

        public Node((int, int) location)
        {
            this.Location = location;
        }
    }
}
