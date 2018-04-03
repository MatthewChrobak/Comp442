using SyntacticAnalyzer.Semantics;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Xml.Serialization;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class StatBlock : Node, IVisitable
    {
        [XmlArrayItem(type:typeof(VarDecl), elementName:"VarDecl")]
        [XmlArrayItem(type:typeof(AssignStat), elementName:"Assignment")]
        [XmlArrayItem(type:typeof(IfStat), elementName:"If")]
        [XmlArrayItem(type:typeof(ForStat), elementName:"For")]
        [XmlArrayItem(type:typeof(GetStat), elementName:"Get")]
        [XmlArrayItem(type: typeof(PutStat), elementName: "Put")]
        [XmlArrayItem(type: typeof(ReturnStat), elementName: "Return")]
        public List<object> Statements { get; set; } = new List<object>();

        [XmlIgnore]
        public SymbolTable Table { get; set; }

        public StatBlock((int, int) location) : base(location)
        {
        }

        public void Accept(Visitor visitor)
        {
            visitor.PreVisit(this);

            foreach (var element in this.Statements) {
                if (element is IVisitable visitable) {
                    visitable?.Accept(visitor);
                }
            }

            visitor.Visit(this);
        }

        public override string ToString()
        {
            if (Statements?.Count > 0) {
                return "{\n" + String.Join(string.Empty, Statements.Select(val => val + ";\n")) + "}";
            }
            return "{\n}";
        }
    }
}
