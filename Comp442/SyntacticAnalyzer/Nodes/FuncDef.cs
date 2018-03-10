using SyntacticAnalyzer.Semantics;
using System;
using System.Collections.Generic;
using System.Xml.Serialization;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class FuncDef : Node, IVisitable
    {
        public string ReturnType { get; set; }
        public ScopeSpec ScopeResolution { get; set; }
        public string FunctionName { get; set; }

        [XmlArray("Parameters")]
        [XmlArrayItem("Parameter")]
        public List<FParam> Parameters { get; set; } = new List<FParam>();
        public StatBlock Implementation { get; set; }

        [XmlIgnore]
        public TableEntry Entry { get; set; }

        public FuncDef((int, int) location) : base(location)
        {
        }

        public void Accept(Visitor visitor)
        {
            foreach (var parameter in this.Parameters) {
                parameter.Accept(visitor);
            }
            this.Implementation.Accept(visitor);

            visitor.Visit(this);
        }

        public override string ToString()
        {
            if (this.Parameters?.Count > 0) {
                return $"{this.ReturnType} {this.ScopeResolution}{this.FunctionName}({string.Join(",", this.Parameters)}){this.Implementation};\n";
            }
            return $"{this.ReturnType} {this.ScopeResolution}{this.FunctionName}(){this.Implementation};\n";
        }
    }
}
