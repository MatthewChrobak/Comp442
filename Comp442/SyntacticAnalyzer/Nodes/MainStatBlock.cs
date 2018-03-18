using SyntacticAnalyzer.Semantics;
using System;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class MainStatBlock : StatBlock, IVisitable
    {
        public MainStatBlock(StatBlock originalStatBlock) : base(originalStatBlock == null ? (0, 0) : originalStatBlock.Location)
        {
            this.Statements = originalStatBlock?.Statements;
            this.Table = originalStatBlock?.Table;

            if (this.Statements == null) {
                this.Statements = new System.Collections.Generic.List<object>();
            }
            if (this.Table == null) {
                this.Table = new SymbolTable();
            }
        }

        public new void Accept(Visitor visitor)
        {
            visitor.PreVisit(this);

            foreach (var element in this.Statements) {
                if (element is IVisitable visitable) {
                    visitable.Accept(visitor);
                }
            }

            visitor.Visit(this);
        }
    }
}
