using Errors;
using SyntacticAnalyzer.Nodes;
using SyntacticAnalyzer.Semantics;
using System.Collections.Generic;

namespace CodeGeneration.Visitors
{
    public class MemorySizeVisitor : Visitor
    {
        public Dictionary<string, int> Sizes = new Dictionary<string, int>();

        public SymbolTable GlobalSymbolTable;
        private TableEntry LastScopeLink = null;

        public MemorySizeVisitor(SymbolTable symbolTable)
        {
            this.GlobalSymbolTable = symbolTable;

            this.Sizes.Add("float", 4);
            this.Sizes.Add("int", 4);
        }

        public override void PreVisit(ClassDecl classDecl)
        {
            this.LastScopeLink = this.GlobalSymbolTable.Get(classDecl.ClassName, Classification.Class);
        }

        public override void PreVisit(FuncDef funcDef)
        {
            this.LastScopeLink = this.GlobalSymbolTable.Get(funcDef.FunctionName, Classification.Function);
        }

        public override void PreVisit(MainStatBlock mainStatBlock)
        {
            this.LastScopeLink = this.GlobalSymbolTable.Get("main", Classification.Function);
        }

        public override void Visit(ClassList classList)
        {
            while (true) {
                bool modifications = false;

                foreach (var classNode in classList.Classes) {
                    string entryName = classNode.ClassName;
                    var @class = GlobalSymbolTable.Get(entryName, Classification.Class);

                    // Make sure it doesn't exist first.
                    if (Sizes.ContainsKey(entryName)) {
                        continue;
                    }

                    int size = 0;
                    bool complete = true;
                    
                    foreach (var entry in @class.Link.GetAll(Classification.Variable)) {

                        // Is the memory size already calculated?
                        if (entry.EntryMemorySize > 0) {
                            size += entry.EntryMemorySize;
                            continue;
                        }

                        // It's not. Let's try and figure it out.
                        string type = entry.Type.Replace("[]", string.Empty);

                        if (Sizes.ContainsKey(type)) {
                            entry.EntryMemorySize *= -Sizes[type];
                            size += entry.EntryMemorySize;
                        } else {
                            complete = false;
                            break;
                        }
                    }

                    if (complete) {
                        Sizes.Add(entryName, size);
                        modifications = true;

                        GlobalSymbolTable.Get(entryName, Classification.Class).EntryMemorySize = size;
                    }
                }

                if (!modifications) {
                    break;
                }
            }

            foreach (var entry in GlobalSymbolTable.GetAll(Classification.Class)) {
                if (entry.EntryMemorySize == -1) {
                    Sizes.Add(entry.ID, -1);
                }
            }
        }

        public override void Visit(VarDecl varDecl)
        {
            int count = 1;

            foreach (var dim in varDecl.Dimensions) {
                count *= int.Parse(dim.Value);
            }

            if (!Sizes.ContainsKey(varDecl.Type)) {
                this.LastScopeLink.Link.Get(varDecl.Id, Classification.Variable).EntryMemorySize *= count;
            } else {
                this.LastScopeLink.Link.Get(varDecl.Id, Classification.Variable).EntryMemorySize = Sizes[varDecl.Type] * count;
            }
        }
    }
}
