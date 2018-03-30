using SyntacticAnalyzer.Nodes;
using SyntacticAnalyzer.Semantics;
using System.Collections.Generic;

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

        public override void Visit(Var var)
        {   
            var.offset = currentScope.GetOffset(var.Elements[0].ToString(), Classification.Variable);
        }

        public override void Visit(AParams aParams)
        {
            
        }

        public override void Visit(DataMember dataMember)
        {
            int offset = currentScope.GetOffset(dataMember.Id, Classification.Variable);

            foreach (var index in dataMember.Indexes.Expressions) {

            }
        }

        public override void Visit(FCall fCall)
        {
            
        }
    }
}