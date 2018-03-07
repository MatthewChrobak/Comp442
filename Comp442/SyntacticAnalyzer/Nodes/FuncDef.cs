using SyntacticAnalyzer.Pattern;
using System;
using System.Collections.Generic;
using System.Xml.Serialization;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class FuncDef : IVisitable
    {
        public string ReturnType { get; set; }
        public ScopeSpec ScopeResolution { get; set; }
        public string FunctionName { get; set; }

        [XmlArray("Parameters")]
        [XmlArrayItem("Parameter")]
        public List<FParam> Parameters { get; set; } = new List<FParam>();
        public StatBlock Implementation { get; set; }

        public void Accept(Visitor visitor)
        {
            visitor.Visit(this);
        }

        public override string ToString()
        {
            if (Parameters?.Count > 0) {
                return $"{ReturnType} {ScopeResolution}{FunctionName}({string.Join(",", Parameters)}){Implementation};\n";
            }
            return $"{ReturnType} {ScopeResolution}{FunctionName}(){Implementation};\n";
        }
    }
}
