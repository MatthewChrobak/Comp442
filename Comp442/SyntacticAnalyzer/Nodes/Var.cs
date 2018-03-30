using SyntacticAnalyzer.Semantics;
using System;
using System.Collections.Generic;
using System.Xml.Serialization;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class Var : Node, IVisitable
    {
        [XmlArrayItem(type:typeof(AParams), elementName:"Params")]
        [XmlArrayItem(type:typeof(DataMember), elementName:"DataMember")]
        [XmlArrayItem(type:typeof(FCall), elementName:"FunctionCall")]
        public List<Node> Elements { get; set; } = new List<Node>();

        public Var((int, int) location) : base(location)
        {
        }

        public void Accept(Visitor visitor)
        {
            visitor.PreVisit(this);
            foreach (var element in this.Elements) {
                if (element is IVisitable visitable) {
                    visitable?.Accept(visitor);
                }
            }

            visitor.Visit(this);
        }

        public override string ToString()
        {
            if (Elements?.Count > 0) {
                return String.Join(".", Elements);
            }
            return string.Empty;
        }
    }
}
