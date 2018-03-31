using SyntacticAnalyzer.Semantics;
using System.Collections.Generic;

namespace CodeGeneration.Visitors
{
    public class NewStackIncreaserVisitor : Visitor
    {
        private SymbolTable table;
        private Dictionary<string, int> sizes;

        public NewStackIncreaserVisitor(SymbolTable table, Dictionary<string, int> sizes)
        {
            this.table = table;
            this.sizes = sizes;
        }
    }
}
