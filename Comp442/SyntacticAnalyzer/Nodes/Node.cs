using System.Xml.Serialization;

namespace SyntacticAnalyzer.Nodes
{
    public class Node
    {
        [XmlIgnore]
        public (int line, int column) Location { get; private set; }

        [XmlIgnore]
        public string SemanticalType { get; set; } = "null";

        public Node((int, int) location)
        {
            this.Location = location;
        }
    }
}
