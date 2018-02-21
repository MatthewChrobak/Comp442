using System;
using System.Collections.Generic;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class ClassList
    {
        public List<ClassDecl> Classes { get; set; } = new List<ClassDecl>();
    }
}
