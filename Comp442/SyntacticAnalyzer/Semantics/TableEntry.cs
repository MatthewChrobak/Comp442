namespace SyntacticAnalyzer.Semantics
{
    public class TableEntry
    {
        public string ID { get; private set; }
        public TableEntryType EntryType { get; private set; }
        public SymbolTable Link { get; set; }

        public TableEntry(string id, TableEntryType type)
        {
            this.ID = id;
            this.EntryType = type;
        }

        public override string ToString()
        {
            return $"{this.ID}:{this.EntryType}";
        }
    }
}
