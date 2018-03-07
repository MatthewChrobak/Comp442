using System.Collections.Generic;
using System.Linq;

namespace SemanticalAnalyzer.SymbolTables
{
    public enum TableEntryType
    {
        Scope,
        Function,
        Variable,
        Class
    }

    public class TableEntry
    {
        public string ID { get; private set; }
        public TableEntryType EntryType { get; private set; }

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

    public class Scope : TableEntry
    {
        private Dictionary<string, TableEntry> _entries { get; set; }

        public Scope(string name) : base(name, TableEntryType.Scope)
        {
            this._entries = new Dictionary<string, TableEntry>();
        }

        public void Add(string key, TableEntry value)
        {
            this._entries.Add(key, value);
        }

        public IEnumerable<KeyValuePair<string, TableEntry>> GetAll<T>() where T : TableEntry
        {
            return this._entries.Where(val => val.Value as T != null);
        }
    }

    public class Class : TableEntry
    {
        public Scope ClassScope { get; private set; }

        public Class(string name) : base(name, TableEntryType.Class)
        {
            this.ClassScope = new Scope("Class Scope");
        }
    }

    public class Function : TableEntry
    {
        public Scope FunctionScope { get; private set; }

        public Function(string name) : base(name, TableEntryType.Function)
        {
            this.FunctionScope = new Scope("Function Scope");
        }
    }

    public class Variable : TableEntry
    {
        public Variable(string name) : base(name, TableEntryType.Variable)
        {

        }
    }
}
