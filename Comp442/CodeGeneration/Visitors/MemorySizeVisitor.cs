using Errors;
using SyntacticAnalyzer.Nodes;
using SyntacticAnalyzer.Semantics;
using System.Collections.Generic;
using System.Linq;

namespace CodeGeneration.Visitors
{
    public class MemorySizeVisitor : Visitor
    {
        public Dictionary<string, int> Sizes;

        private SymbolTable GlobalScope;
        private SymbolTable FunctionScope;
        private SymbolTable ClassInstanceScope;
        private bool DoneClassList = false;

        public MemorySizeVisitor(SymbolTable globalScope)
        {
            this.GlobalScope = globalScope;

            this.Sizes = new Dictionary<string, int>();
            this.Sizes.Add("float", 8);
            this.Sizes.Add("int", 4);
        }

        public override void PreVisit(ClassDecl classDecl)
        {
            this.FunctionScope = new SymbolTable();
            this.ClassInstanceScope = this.GlobalScope.Get(classDecl.ClassName, Classification.Class).Link;
        }

        public override void Visit(ClassList classList)
        {
            while (true) {
                bool modifications = false;

                foreach (var classNode in classList.Classes) {
                    string entryName = classNode.ClassName;

                    // Make sure it doesn't exist first.
                    if (Sizes.ContainsKey(entryName)) {
                        continue;
                    }

                    int size = 0;
                    bool complete = true;
                    var @class = GlobalScope.Get(entryName, Classification.Class);

                    foreach (var entry in @class.Link.GetAll(Classification.Variable)) {

                        // Is the memory size already calculated?
                        if (entry.EntryMemorySize >= 0) {
                            size += entry.EntryMemorySize;
                            continue;
                        }

                        // It's not. Let's try and figure it out.
                        // Get the base type
                        string type = entry.Type.Replace("[]", string.Empty);

                        // Is the base-type defined?
                        if (Sizes.ContainsKey(type)) {
                            entry.EntryMemorySize *= -Sizes[type];
                            size += entry.EntryMemorySize;
                        } else {
                            complete = false;
                            break;
                        }
                    }

                    // Is the type complete?
                    if (complete) {
                        Sizes.Add(entryName, size);
                        modifications = true;

                        // Set the class size.
                        GlobalScope.Get(entryName, Classification.Class).EntryMemorySize = size;
                    }
                }

                if (!modifications) {
                    break;
                }
            }

            foreach (var entry in GlobalScope.GetAll(Classification.Class)) {
                if (entry.EntryMemorySize == -1) {
                    ErrorManager.Add($"The size of the class {entry.ID} could not be established.", (0, 0));
                    Sizes.Add(entry.ID, -1);
                }
            }

            this.DoneClassList = true;
        }


        public override void PreVisit(FuncDef funcDef)
        {
            var functionEntry = this.GlobalScope.Get(funcDef.Entry.ID, Classification.Function);
            var newFunctionScope = new SymbolTable();

            foreach (var oldEntry in functionEntry.Link.GetAll()) {
                if (oldEntry.Classification == Classification.Parameter) {
                    newFunctionScope.Add(new TableEntry(oldEntry.ID, Classification.Variable, oldEntry.EntryMemorySize), (0, 0));
                } else {
                    newFunctionScope.Add(oldEntry, (0, 0));
                }
            }

            functionEntry.Link = newFunctionScope;

            this.FunctionScope = this.GlobalScope.Get(funcDef.Entry.ID, Classification.Function).Link;

            this.ClassInstanceScope = new SymbolTable();
            if (funcDef.ScopeResolution != null) {
                this.ClassInstanceScope = this.GlobalScope.Get(funcDef.ScopeResolution.ID, Classification.Class).Link;
                funcDef.ScopeResolution.NodeMemorySize = Sizes[funcDef.ScopeResolution.ID];
            }

            funcDef.NodeMemorySize = Sizes[funcDef.ReturnType];
        }
        
        public override void PreVisit(MainStatBlock mainStatBlock)
        {
            this.FunctionScope = this.GlobalScope.Get("main", Classification.Function).Link;
            this.ClassInstanceScope = new SymbolTable();
        }

        public override void Visit(VarDecl varDecl)
        {
            int numElements = 1;
            var dimensions = new List<int>();

            // Calculate the dimensions and the total size.
            foreach (var dimension in varDecl.Dimensions) {
                dimensions.Add(int.Parse(dimension.Value));
                numElements *= dimensions.Last();
            }

            var nodeEntry = this.GetCurrentScope().Get(varDecl.Id, Classification.Variable);


            if (!this.Sizes.ContainsKey(varDecl.Type)) {
                // If it doesn't exist, the memory size will be -1. By multiplying it by the number of elements,
                // the true size will happen when (in the class) we resolve it by doing *= -sizeof(type);
                nodeEntry.EntryMemorySize *= numElements;
            } else {
                nodeEntry.EntryMemorySize = Sizes[varDecl.Type] * numElements;
            }

            nodeEntry.MaxSizeDimensions = dimensions;
        }

        public override void Visit(Var var)
        {
            var scope = GetCurrentScope();
            string lastMemberType = string.Empty;

            foreach (var element in var.Elements) {

                if (element is DataMember member) {
                    // Get the base variable of this data member.
                    var baseVariable = scope.Get(member.Id, Classification.Variable);
 
                    string baseVariableType = member.SemanticalType.Replace("[]", string.Empty);

                    // Calculate the number of elements in this data member based on the number of unspecified dimensions.
                    int numDimensionsRemaining = member.SemanticalType.Count(val => val == '[');
                    int numElements = 1;
                    int i = baseVariable.MaxSizeDimensions.Count - 1;

                    while (numDimensionsRemaining-- > 0) {
                        numElements *= baseVariable.MaxSizeDimensions[i--];
                    }

                    // Save this for later.
                    lastMemberType = baseVariableType;

                    // Transfer this for later.
                    member.MaxSizeDimensions = baseVariable.MaxSizeDimensions;

                    // Calculate the memory size.
                    member.NodeMemorySize = numElements * Sizes[baseVariableType];

                    // Update the scope for the dot operator.
                    scope = this.GlobalScope.Get(member.SemanticalType, Classification.Class)?.Link;
                }

                if (element is FCall call) {
                    call.NodeMemorySize = Sizes[call.SemanticalType];

                    if (lastMemberType.Length != 0) {
                        call.MemberMemorySize = Sizes[lastMemberType];
                    }

                    lastMemberType = call.SemanticalType;

                    scope = this.GlobalScope.Get(call.SemanticalType, Classification.Class)?.Link;
                }
            }

            var.NodeMemorySize = var.Elements.Last().NodeMemorySize;
        }

        public override void Visit(FParam fParam)
        {
            if (!this.DoneClassList) {
                return;
            }

            int numElements = 1;
            var dimensions = new List<int>();

            // Calculate the dimensions and the total size.
            foreach (var dimension in fParam.Dimensions) {
                dimensions.Add(int.Parse(dimension.Value));
                numElements *= dimensions.Last();
            }
            
            var nodeEntry = this.GetCurrentScope().Get(fParam.Id, Classification.Variable);

            if (!this.Sizes.ContainsKey(fParam.Type)) {
                // If it doesn't exist, the memory size will be -1. By multiplying it by the number of elements,
                // the true size will happen when (in the class) we resolve it by doing *= -sizeof(type);
                nodeEntry.EntryMemorySize *= numElements;
            } else {
                nodeEntry.EntryMemorySize = Sizes[fParam.Type] * numElements;
            }

            nodeEntry.MaxSizeDimensions = dimensions;
        }

        public override void Visit(Integer integer)
        {
            integer.NodeMemorySize = Sizes[integer.SemanticalType];
        }

        public override void Visit(Float @float)
        {
            @float.NodeMemorySize = Sizes[@float.SemanticalType];
        }

        public override void Visit(Sign sign)
        {
            sign.NodeMemorySize = Sizes[sign.Factor.SemanticalType];
        }

        public override void Visit(AddOp addOp)
        {
            addOp.NodeMemorySize = Sizes[addOp.SemanticalType];
        }

        public override void Visit(MultOp multOp)
        {
            multOp.NodeMemorySize = Sizes[multOp.SemanticalType];
        }

        public override void Visit(RelExpr relExpr)
        {
            relExpr.NodeMemorySize = Sizes[relExpr.SemanticalType];
        }

        public override void Visit(Not not)
        {
            not.NodeMemorySize = Sizes[not.SemanticalType];
        }

        public override void PreVisit(ForStat forStat)
        {
            var variable = this.FunctionScope.Get(forStat.Id, Classification.Variable);

            if (variable != null) {
                if (variable.EntryMemorySize < Sizes[forStat.Type]) {
                    variable.EntryMemorySize = Sizes[forStat.Type];
                }
            } else {
                this.FunctionScope.Add(new TableEntry(forStat.Id, Classification.Variable, Sizes[forStat.Type]), (0, 0));
            }
        }

        public override void Visit(ForStat forStat)
        {
            forStat.NodeMemorySize = Sizes[forStat.Type];
        }

        public SymbolTable GetCurrentScope()
        {
            var table = new SymbolTable();
            table.AddRange(this.GlobalScope.GetAll(), (0, 0));
            table.AddRange(this.FunctionScope?.GetAll(), (0, 0));
            table.AddRange(this.ClassInstanceScope?.GetAll(), (0, 0));
            return table;
        }
    }
}
