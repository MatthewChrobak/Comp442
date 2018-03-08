using System.Collections.Generic;
using System.Linq;

namespace SyntacticAnalyzer.Semantics
{
    public class SymbolTable
    {
        private Dictionary<string, TableEntry> _entries { get; set; }

        public SymbolTable()
        {
            this._entries = new Dictionary<string, TableEntry>();
        }

        public void Add(TableEntry value)
        {
            string key = value.ToString();

            if (this._entries.ContainsKey(key)) {
                throw new System.Exception();
            }

            this._entries.Add(key, value);
        }

        public IEnumerable<TableEntry> GetAll(TableEntryType? type = null)
        {
            if (type == null) {
                return this._entries.Values;
            }
            return this._entries.Where(val => val.Value.EntryType == type).Select(val => val.Value);
        }
    }
}
