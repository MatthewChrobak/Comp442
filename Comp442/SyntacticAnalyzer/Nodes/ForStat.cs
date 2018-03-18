using SyntacticAnalyzer.Semantics;
using System;
using System.Xml.Serialization;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class ForStat : Node, IVisitable
    {
        public string Type { get; set; }
        public string Id { get; set; }

        [XmlIgnore]
        public (int, int) IdLocation { get; set; }

        [XmlElement(type: typeof(AddOp), elementName: "AddOp")] // arithExpr
        [XmlElement(type: typeof(RelExpr), elementName: "RelationalExpression")] // expr
        [XmlElement(type: typeof(MultOp), elementName: "MultOp")] // term
        [XmlElement(type: typeof(Var), elementName: "Variable")] // factor
        [XmlElement(type: typeof(Integer), elementName: "Integer")] // factor
        [XmlElement(type: typeof(Float), elementName: "Float")] // factor
        [XmlElement(type: typeof(FCall), elementName: "FunctionCall")] // factor
        [XmlElement(type: typeof(Not), elementName: "NotFactor")] // factor
        [XmlElement(type: typeof(Sign), elementName: "SignFactor")] // factor
        public object Initialization { get; set; } // Resolves to EXPR

        public RelExpr Condition { get; set; }
        public AssignStat Update { get; set; }
        public StatBlock LoopBlock { get; set; }

        public ForStat((int, int) location) : base(location)
        {
        }

        public void Accept(Visitor visitor)
        {
            visitor.PreVisit(this);
            if (this.Initialization is IVisitable initialization) {
                initialization?.Accept(visitor);
            }
            this.Condition?.Accept(visitor);
            this.Update?.Accept(visitor);
            this.LoopBlock?.Accept(visitor);

            visitor.Visit(this);
        }

        public override string ToString()
        {
            return $"for ({this.Type} {this.Id} ={this.Initialization};{this.Condition};{this.Update}) {this.LoopBlock}";
        }
    }
}
