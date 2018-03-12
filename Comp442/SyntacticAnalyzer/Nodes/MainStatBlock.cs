using SyntacticAnalyzer.Semantics;
using System;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class MainStatBlock : StatBlock, IVisitable
    {
        public MainStatBlock(StatBlock originalStatBlock) : base(originalStatBlock.Location)
        {
            this.Statements = originalStatBlock.Statements;
            this.Table = originalStatBlock.Table;
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
