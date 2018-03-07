﻿using SyntacticAnalyzer.Pattern;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Xml.Serialization;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class FuncDecl : IVisitable
    {
        public string Type { get; set; }
        public string Id { get; set; }

        [XmlArray("Parameters")]
        [XmlArrayItem("Parameter")]
        public List<FParam> Parameters { get; set; } = new List<FParam>();

        public void Accept(Visitor visitor)
        {
            visitor.Visit(this);
        }

        public override string ToString()
        {
            if (Parameters?.Count > 0) {
                return $"{Type} {Id}({Parameters.Select(val => val.ToString()).Aggregate((sentence, next) => "," + next)})";
            } else {
                return $"{Type} {Id}()";
            }
        }
    }
}
