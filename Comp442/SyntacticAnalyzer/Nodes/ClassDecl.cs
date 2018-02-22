using System;
using System.Collections.Generic;
using System.Xml.Serialization;

namespace SyntacticAnalyzer.Nodes
{
    [XmlInclude(typeof(VarDecl))]
    [XmlInclude(typeof(FuncDecl))]
    [Serializable]
    public class ClassDecl
    {
        public InherList InheritingClasses;

        [XmlArray("MemberList")]
        [XmlArrayItem("Variable", type: typeof(VarDecl))]
        [XmlArrayItem("Function", type: typeof(FuncDecl))]
        public List<object> Members { get; set; } = new List<object>();
    }
}
