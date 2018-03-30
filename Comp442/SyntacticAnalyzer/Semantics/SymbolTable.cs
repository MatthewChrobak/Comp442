using Errors;
using System;
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

        public void AddToStack(string id, int size)
        {
            this.Add(new TableEntry(id, Classification.SubCalculationStackSpace, size), (0, 0));
        }

        public void Add(TableEntry value, (int, int) location, bool overrideEntry = false)
        {
            if (value == null) {
                return;
            }

            string key = value.ToString();

            if (this._entries.ContainsKey(key)) {
                if (value.Classification == Classification.SubCalculationStackSpace) {
                    return;
                }
                if (overrideEntry) {
                    WarningManager.Add($"The {value.Classification} {value.ID} is overshadowing a previously existing member of this ID and type.", location);
                    return;
                }
                ErrorManager.Add($"The {value.Classification} {value.ID} is already defined in this scope.", location);
                return;
            }

            this._entries.Add(key, value);
        }

        public void AddRange(IEnumerable<TableEntry> entries, (int, int) location, bool overrideEntries = false)
        {
            if (entries == null) {
                return;
            }
            foreach (var entry in entries) {
                this.Add(entry, location, overrideEntries);
            }
        }

        public TableEntry Get(string key)
        {
            if (this._entries.ContainsKey(key)) {
                return this._entries[key];
            }
            return null;
        }

        public TableEntry Get(string id, Classification type)
        {
            return this.Get($"{id}-{type}");
        }

        public IEnumerable<TableEntry> GetAll(Classification? type = null)
        {
            if (type == null) {
                return this._entries.Values;
            }
            return this._entries.Where(val => val.Value.Classification == type).Select(val => val.Value);
        }

        public void Remove(string id, Classification variable)
        {
            if (this.Get($"{id}-{variable}") != null) {
                this._entries.Remove($"{id}-{variable}");
            }
        }

        public int GetOffset(string id, Classification type)
        {
            return this.GetOffset(new TableEntry(id, type, 0));
        }

        public int GetOffset(TableEntry entry)
        {
            int offset = 0;

            foreach (var tableEntry in this._entries) {
                if (tableEntry.Key == $"{entry.ID}-{entry.Classification}") {
                    return offset;
                }
                offset += tableEntry.Value.EntryMemorySize;
            }

            return -1;
        }
    }
}
