﻿using SyntacticAnalyzer.Semantics;
using System;
using System.Collections.Generic;
using System.Linq;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class InherList : Node, IVisitable
    {
        public List<string> IDs { get; set; } = new List<string>();

        public void Accept(Visitor visitor)
        {
            visitor.Visit(this);
        }

        public override string ToString()
        {
            if (IDs?.Count > 0) {
                return ":" + IDs.Aggregate((sentence, value) => sentence + "," + value);
            }
            return string.Empty;
        }
    }
}
