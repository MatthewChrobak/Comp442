﻿using SyntacticAnalyzer.Semantics;
using System;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class DataMember : Node, IVisitable
    {
        public string Id { get; set; }
        public IndexList Indexes { get; set; }

        public DataMember((int, int) location) : base(location)
        {
        }

        public void Accept(Visitor visitor)
        {
            visitor.Visit(this);
        }

        public override string ToString()
        {
            return Id + Indexes;
        }
    }
}
