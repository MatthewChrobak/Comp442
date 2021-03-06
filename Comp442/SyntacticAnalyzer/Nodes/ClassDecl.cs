﻿using SyntacticAnalyzer.Semantics;
using System;
using System.Collections.Generic;
using System.Xml.Serialization;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class ClassDecl : Node, IVisitable
    {
        public InherList InheritingClasses { get; set; }

        public string ClassName { get; set; }

        [XmlArray("MemberList")]
        [XmlArrayItem("Variable", type: typeof(VarDecl))]
        [XmlArrayItem("Function", type: typeof(FuncDecl))]
        public List<object> Members { get; set; } = new List<object>();

        [XmlIgnore]
        public SymbolTable Table { get; set; }

        // Just used for serialization.
        public ClassDecl() : base((-1, -1))
        {

        }

        public ClassDecl((int, int) location) : base(location)
        {
        }

        public void Accept(Visitor visitor)
        {
            visitor.PreVisit(this);
            this.InheritingClasses?.Accept(visitor);
            foreach (var entry in this.Members) {
                if (entry is IVisitable visitable) {
                    visitable?.Accept(visitor);
                }
            }

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
