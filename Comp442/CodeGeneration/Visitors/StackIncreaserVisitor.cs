using SyntacticAnalyzer.Nodes;
using SyntacticAnalyzer.Semantics;
using System.Collections.Generic;
using System.Linq;

namespace CodeGeneration.Visitors
{
    public class StackIncreaserVisitor : Visitor
    {
        private SymbolTable GlobalScope;
        private SymbolTable FunctionScope;
        private SymbolTable ClassInstanceScope;

        private Dictionary<string, int> Sizes;

        public StackIncreaserVisitor(SymbolTable globalScope, Dictionary<string, int> sizes)
        {
            this.GlobalScope = globalScope;
            this.Sizes = sizes;
        }

        public override void PreVisit(MainStatBlock mainStatBlock)
        {
            this.FunctionScope = GlobalScope.Get("main", Classification.Function).Link;
            this.ClassInstanceScope = new SymbolTable();
        }

        public override void PreVisit(FuncDef funcDef)
        {
            var link = GlobalScope.Get(funcDef.FunctionName, Classification.Function);

            var table = new SymbolTable();
            int size = Sizes[funcDef.ReturnType];
            table.Add(new TableEntry("retval", Classification.SubCalculationStackSpace, size), (0, 0));

            link.Link = table;

            this.FunctionScope = table;//GlobalScope.Get(funcDef.FunctionName, Classification.Function).Link;



            if (funcDef.ScopeResolution != null) {
                this.ClassInstanceScope = this.GlobalScope.Get(funcDef.ScopeResolution.ID, Classification.Class).Link;
            }
        }

        public override void Visit(Sign sign)
        {
            this.FunctionScope.AddToStack(sign.ToString(), Sizes[sign.Factor.SemanticalType]);
            sign.stackOffset = this.FunctionScope.GetOffset(sign.ToString(), Classification.SubCalculationStackSpace);
        }

        public override void Visit(Integer integer)
        {
            this.FunctionScope.AddToStack(integer.Value, Sizes["int"]);
            integer.stackOffset = this.FunctionScope.GetOffset(integer.Value, Classification.SubCalculationStackSpace);
        }

        public override void Visit(AddOp addOp)
        {
            this.FunctionScope.AddToStack(addOp.ToString(), Sizes[addOp.SemanticalType]);
            addOp.stackOffset = this.FunctionScope.GetOffset(addOp.ToString(), Classification.SubCalculationStackSpace);
        }

        public override void Visit(MultOp multOp)
        {
            this.FunctionScope.AddToStack(multOp.ToString(), Sizes[multOp.SemanticalType]);
            multOp.stackOffset = this.FunctionScope.GetOffset(multOp.ToString(), Classification.SubCalculationStackSpace);
        }

        public override void Visit(Var var)
        {
            SymbolTable currentScope = new SymbolTable();
            currentScope.AddRange(FunctionScope.GetAll(), var.Location);
            currentScope.AddRange(GlobalScope.GetAll(), var.Location);
            currentScope.AddRange(ClassInstanceScope.GetAll(), var.Location);

            foreach (var element in var.Elements) {

                if (element is DataMember dataMember) {

                    var entry = currentScope.Get(dataMember.Id, Classification.Variable);
                    int size = entry.EntryMemorySize;

                    for (int i = 0; i < entry.MaxSizeDimensions.Count && i < dataMember.Indexes?.Expressions?.Count; i++) {
                        size /= entry.MaxSizeDimensions[i];
                    }

                    this.FunctionScope.AddToStack(dataMember.ToString(), size);
                    dataMember.stackOffset = this.FunctionScope.GetOffset(dataMember.ToString(), Classification.SubCalculationStackSpace);
                    dataMember.baseOffset = this.FunctionScope.GetOffset(entry);

                    currentScope = new SymbolTable();
                    currentScope.AddRange(GlobalScope.Get($"{dataMember.SemanticalType}-{Classification.Class}")?.Link?.GetAll(), var.Location);
                }

                if (element is FCall fCall) {
                    var entry = currentScope.Get(fCall.Id, Classification.Function);
                    int size = Sizes[fCall.SemanticalType.Split('-')[0]];

                    this.FunctionScope.AddToStack(fCall.ToString(), size);
                    fCall.stackOffset = this.FunctionScope.GetOffset(fCall.ToString(), Classification.SubCalculationStackSpace);
                }
            }

            this.FunctionScope.AddToStack(var.ToString(), var.Elements.Last().NodeMemorySize);
            var.stackOffset = this.FunctionScope.GetOffset(var.ToString(), Classification.SubCalculationStackSpace);
        }
    }
}