namespace SyntacticAnalyzer.Nodes
{
    public class Node
    {
        public (int line, int column) Location { get; private set; }

        public Node((int, int) location)
        {
            this.Location = location;
        }
    }
}
