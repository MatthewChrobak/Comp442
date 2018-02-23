using System;
using System.Collections.Generic;
using System.Xml.Serialization;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class ClassDecl
    {
        public InherList InheritingClasses;

        [XmlArray("MemberList")]
        [XmlArrayItem("Variable", type: typeof(VarDecl))]
        [XmlArrayItem("Function", type: typeof(FuncDecl))]
        public List<object> Members { get; set; } = new List<object>();

        public override string ToString()
        {
            return "class someclass" + InheritingClasses.ToString() + "{" + string.Join(";\n", Members) + "};";
        }
    }
}
