﻿using SyntacticAnalyzer.Semantics;
using System;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class FCall : Node, IVisitable
    {
        public string Id { get; set; }
        public AParams Parameters { get; set; }

        public FCall((int, int) location) : base(location)
        {
        }

        public void Accept(Visitor visitor)
        {
            this.Parameters.Accept(visitor);
            visitor.Visit(this);
        }

        public override string ToString()
        {
            return $"{Id}({Parameters})";
        }
    }
}
