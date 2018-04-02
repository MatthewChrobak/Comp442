using SyntacticAnalyzer.Nodes;
using SyntacticAnalyzer.Semantics;
using System.Collections.Generic;

namespace CodeGeneration.Visitors
{
    public class StackIncreaserVisitor : Visitor
    {
        public Dictionary<string, int> Sizes;

        private SymbolTable GlobalScope;
        private TableEntry FunctionScopeLink;
        private SymbolTable ClassInstanceScope;

        public StackIncreaserVisitor(SymbolTable globalScope)
        {
            this.GlobalScope = globalScope;
        }

        public override void PreVisit(MainStatBlock mainStatBlock)
        {
            this.FunctionScopeLink = this.GlobalScope.Get("main", Classification.Function);
            this.ClassInstanceScope = new SymbolTable();
        }

        public override void PreVisit(ClassDecl classDecl)
        {
            this.FunctionScopeLink = null;
            this.ClassInstanceScope = this.GlobalScope.Get(classDecl.ClassName, Classification.Class).Link;
        }

        public override void PreVisit(FuncDef funcDef)
        {
            // Transfer scopes.
            this.FunctionScopeLink = this.GlobalScope.Get(funcDef.Entry.ID, Classification.Function);

            this.ClassInstanceScope = new SymbolTable();
            if (funcDef.ScopeResolution != null) {
                this.ClassInstanceScope = this.GlobalScope.Get(funcDef.ScopeResolution.ID, Classification.Class).Link;
            }

            var newFunctionScope = new SymbolTable();

            // Add the return values.
            newFunctionScope.Add(new TableEntry("retaddr", Classification.SubCalculationStackSpace, 4), (0, 0));
            newFunctionScope.Add(new TableEntry("retval", Classification.SubCalculationStackSpace, funcDef.NodeMemorySize), (0, 0));
            newFunctionScope.AddRange(this.FunctionScopeLink.Link.GetAll(), (0, 0));

            FunctionScopeLink.Link = newFunctionScope;
        }



        public override void Visit(Integer integer)
        {
            this.AddToStack(integer);
        }

        public override void Visit(Sign sign)
        {
            this.AddToStack(sign);
        }

        public override void Visit(AddOp addOp)
        {
            this.AddToStack(addOp);
        }

        public override void Visit(MultOp multOp)
        {
            this.AddToStack(multOp);
        }

        public override void Visit(Var var)
        {
            var currentScope = this.FunctionScopeLink?.Link;

            foreach (var element in var.Elements) {
                if (element is DataMember member) {
                    this.AddToStack(member, this.FunctionScopeLink?.Link, this.FunctionScopeLink?.Link);
                    member.baseOffset = currentScope.GetOffset(member.Id, Classification.Variable);

                    currentScope = this.GlobalScope.Get(member.SemanticalType, Classification.Class)?.Link;
                }

                if (element is FCall call) {
                    this.AddToStack(call, this.FunctionScopeLink?.Link, this.FunctionScopeLink?.Link);

                    currentScope = this.GlobalScope.Get(call.SemanticalType, Classification.Class)?.Link;
                }
            }

            this.AddToStack(var, this.FunctionScopeLink?.Link, this.FunctionScopeLink?.Link);
        }



        private void AddToStack(Node node, SymbolTable insertScope = null, SymbolTable offsetScope = null)
        {
            if (insertScope == null) {
                insertScope = this.FunctionScopeLink.Link;
            }
            if (offsetScope == null) {
                offsetScope = this.FunctionScopeLink.Link;
            }
            
            insertScope.AddToStack(node.ToString(), node.NodeMemorySize);
            node.stackOffset = offsetScope.GetOffset(node.ToString(), Classification.SubCalculationStackSpace);
        }

        public SymbolTable GetCurrentScope()
        {
            var table = new SymbolTable();
            table.AddRange(this.GlobalScope.GetAll(), (0, 0));
            table.AddRange(this.FunctionScopeLink?.Link?.GetAll(), (0, 0));
            table.AddRange(this.ClassInstanceScope?.GetAll(), (0, 0));
            return table;
        }
    }
}
