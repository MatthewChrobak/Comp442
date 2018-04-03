using System.Collections.Generic;

namespace SyntacticAnalyzer.Semantics
{
    public class TableEntry
    {
        public string ID { get; private set; }
        public Classification Classification { get; private set; }
        public SymbolTable Link { get; set; }
        public string Type { get; set; }
        public int EntryMemorySize { get; set; }
        public List<int> MaxSizeDimensions { get; set; } = new List<int>();

        public TableEntry(string id, Classification type, int size)
        {
            this.ID = id;
            this.Classification = type;
            this.EntryMemorySize = size;
        }

        public override string ToString()
        {
            return $"{this.ID}-{this.Classification}";
        }
    }
}
