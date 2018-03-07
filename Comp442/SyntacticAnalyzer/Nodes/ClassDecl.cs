using SyntacticAnalyzer.Pattern;
using System;
using System.Collections.Generic;
using System.Xml.Serialization;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class ClassDecl : IVisitable
    {
        public InherList InheritingClasses { get; set; }

        public string ClassName { get; set; }

        [XmlArray("MemberList")]
        [XmlArrayItem("Variable", type: typeof(VarDecl))]
        [XmlArrayItem("Function", type: typeof(FuncDecl))]
        public List<object> Members { get; set; } = new List<object>();

        public void Accept(Visitor visitor)
        {
            visitor.Visit(this);
        }

        public override string ToString()
        {
            if (Members?.Count > 0) {
                return "class " + ClassName + InheritingClasses + "{\n" + string.Join(";\n", Members) + ";\n};\n";
            }
            return "class " + ClassName + InheritingClasses + "{\n};\n";
        }
    }
}
