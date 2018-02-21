using System;
using System.Collections.Generic;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class ClassListNode
    {
        public List<ClassDecl> ClassList { get; set; } = new List<ClassDecl>();
    }
}
