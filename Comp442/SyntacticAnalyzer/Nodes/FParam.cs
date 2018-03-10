﻿using SyntacticAnalyzer.Semantics;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Xml.Serialization;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class FParam : Node, IVisitable
    {
        public string Type { get; set; }
        public string Id { get; set; }
        public List<string> Dimensions { get; set; } = new List<string>();

        [XmlIgnore]
        public TableEntry Entry { get; set; }

        public void Accept(Visitor visitor)
        {
            visitor.Visit(this);
        }

        public override string ToString()
        {
            if (Dimensions?.Count > 0) {
                return $"{Type} {Id}{String.Join(string.Empty, Dimensions?.Select(val => $"[{val}]"))}";
            }
            return $"{Type} {Id}";
        }
    }
}
