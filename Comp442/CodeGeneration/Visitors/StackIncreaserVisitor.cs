using SyntacticAnalyzer.Nodes;
using SyntacticAnalyzer.Semantics;
using System.Collections.Generic;

namespace CodeGeneration.Visitors
{
    public class StackIncreaserVisitor : Visitor
    {
        public Dictionary<string, int> Sizes;

        private SymbolTable GlobalScope;
        private SymbolTable FunctionScope;
        private SymbolTable ClassInstanceScope;

        public StackIncreaserVisitor(SymbolTable globalScope)
        {
            this.GlobalScope = globalScope;
        }

        public override void PreVisit(MainStatBlock mainStatBlock)
        {
            this.FunctionScope = this.GlobalScope.Get("main", Classification.Function).Link;
            this.ClassInstanceScope = new SymbolTable();
        }

        public override void PreVisit(ClassDecl classDecl)
        {
            this.FunctionScope = new SymbolTable();
            this.ClassInstanceScope = this.GlobalScope.Get(classDecl.ClassName, Classification.Class).Link;
        }

        public override void PreVisit(FuncDef funcDef)
        {
            // Transfer scopes.
            this.FunctionScope = this.GlobalScope.Get(funcDef.Entry.ID, Classification.Function).Link;

            this.ClassInstanceScope = new SymbolTable();
            if (funcDef.ScopeResolution != null) {
                this.ClassInstanceScope = this.GlobalScope.Get(funcDef.ScopeResolution.ID, Classification.Class).Link;
            }

            // Add the return values.
            this.FunctionScope.Add(new TableEntry("retval", Classification.SubCalculationStackSpace, funcDef.NodeMemorySize), (0, 0));
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
            foreach (var element in var.Elements) {
                if (element is DataMember member) {
                    this.AddToStack(member, this.FunctionScope, this.FunctionScope);
                }

                if (element is FCall call) {
                    this.AddToStack(call, this.FunctionScope, this.FunctionScope);
                }
            }
        }



        private void AddToStack(Node node, SymbolTable insertScope = null, SymbolTable offsetScope = null)
        {
            if (insertScope == null) {
                insertScope = this.FunctionScope;
            }
            if (offsetScope == null) {
                offsetScope = this.FunctionScope;
            }
            
            insertScope.AddToStack(node.ToString(), node.NodeMemorySize);
            node.stackOffset = offsetScope.GetOffset(node.ToString(), Classification.SubCalculationStackSpace);
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
