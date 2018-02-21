using System;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class Term
    {
        public Term LHS { get; set; }
        public string Operator { get; set; }
        public Factor RHS { get; set; }
    }
}
