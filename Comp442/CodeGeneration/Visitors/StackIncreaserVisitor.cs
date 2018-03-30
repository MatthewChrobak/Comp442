using SyntacticAnalyzer.Nodes;
using SyntacticAnalyzer.Semantics;
using System.Collections.Generic;
using System.Linq;

namespace CodeGeneration.Visitors
{
    public class StackIncreaserVisitor : Visitor
    {
        private SymbolTable GlobalScope;

        private SymbolTable currentScope;

        private Dictionary<string, int> Sizes;

        public StackIncreaserVisitor(SymbolTable globalScope, Dictionary<string, int> sizes)
        {
            this.GlobalScope = globalScope;
            this.Sizes = sizes;
        }

        public override void PreVisit(MainStatBlock mainStatBlock)
        {
            this.currentScope = GlobalScope.Get("main", Classification.Function).Link;
        }

        public override void PreVisit(FuncDef funcDef)
        {
            this.currentScope = GlobalScope.Get(funcDef.FunctionName, Classification.Function).Link;
        }

        public override void Visit(Integer integer)
        {
            this.currentScope.AddToStack(integer.Value, Sizes["int"]);
            integer.offset = this.currentScope.GetOffset(integer.Value, Classification.SubCalculationStackSpace);
        }

        public override void Visit(AddOp addOp)
        {
            this.currentScope.AddToStack(addOp.ToString(), Sizes[addOp.SemanticalType]);
            addOp.offset = this.currentScope.GetOffset(addOp.ToString(), Classification.SubCalculationStackSpace);
        }

        public override void Visit(MultOp multOp)
        {
            this.currentScope.AddToStack(multOp.ToString(), Sizes[multOp.SemanticalType]);
            multOp.offset = this.currentScope.GetOffset(multOp.ToString(), Classification.SubCalculationStackSpace);
        }

        public override void Visit(Var var)
        {
            this.currentScope.AddToStack(var.ToString(), 4);
            var.offset = currentScope.GetOffset(var.ToString(), Classification.SubCalculationStackSpace);
        }

        public override void Visit(AParams aParams)
        {
            
        }

        public override void Visit(DataMember dataMember)
        {
            this.currentScope.AddToStack(dataMember.ToString(), 4);
            dataMember.offset = currentScope.GetOffset(dataMember.ToString(), Classification.SubCalculationStackSpace);
            dataMember.baseOffset = currentScope.GetOffset(dataMember.Id, Classification.Variable);
        }

        public override void Visit(FCall fCall)
        {
            
        }
    }
}