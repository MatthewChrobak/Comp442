namespace SyntacticAnalyzer.Semantics
{
    public class TableEntry
    {
        public string ID { get; private set; }
        public Classification Classification { get; private set; }
        public SymbolTable Link { get; set; }
        public string Type { get; set; }

        public TableEntry(string id, Classification type)
        {
            this.ID = id;
            this.Classification = type;
        }

        public override string ToString()
        {
            return $"{this.ID}-{this.Classification}";
        }
    }
}
