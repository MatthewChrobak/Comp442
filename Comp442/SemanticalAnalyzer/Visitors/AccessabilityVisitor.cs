using SyntacticAnalyzer.Nodes;
using SyntacticAnalyzer.Semantics;
using System;

namespace SemanticalAnalyzer.Visitors
{
    public class AccessabilityVisitor : Visitor
    {
        private SymbolTable _currentScope;
        private SymbolTable _globalScope;

        public AccessabilityVisitor(SymbolTable globalScope)
        {
            this._globalScope = globalScope;
        }

        public override void Visit(FuncDef funcDef)
        {
            this._currentScope = funcDef.Entry.Link;
        }

        public override void Visit(Var var)
        {
            foreach (var element in var.Elements) {

                if (element is AParams aparams) {
                    Console.WriteLine(aparams);
                }

                if (element is DataMember dataMember) {
                    Console.WriteLine(dataMember);
                }

                if (element is FCall fcall) {
                    Console.WriteLine(fcall);
                }
            }
        }
    }
}
