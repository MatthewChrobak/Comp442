namespace SyntacticAnalyzer.Nodes
{
    public class Term
    {
        public Term LHS { get; set; }
        public string Operator { get; set; }
        public Factor RHS { get; set; }
    }
}
