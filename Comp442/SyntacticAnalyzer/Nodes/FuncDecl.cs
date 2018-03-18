using SyntacticAnalyzer.Semantics;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Xml.Serialization;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class FuncDecl : Node, IVisitable
    {
        public string Type { get; set; }
        public string Id { get; set; }

        [XmlArray("Parameters")]
        [XmlArrayItem("Parameter")]
        public List<FParam> Parameters { get; set; } = new List<FParam>();

        [XmlIgnore]
        public SymbolTable Table { get; set; }

        public FuncDecl((int, int) location) : base(location)
        {
        }

        public void Accept(Visitor visitor)
        {
            foreach (var param in this.Parameters) {
                param?.Accept(visitor);
            }

            visitor.Visit(this);
        }

        public override string ToString()
        {
            if (Parameters?.Count > 0) {
                return $"{Type} {Id}({Parameters.Select(val => val.ToString()).Aggregate((sentence, next) => "," + next)})";
            } else {
                return $"{Type} {Id}()";
            }
        }
    }
}
