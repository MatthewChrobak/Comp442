using System;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class ClassDecl
    {
        public InherList InheritingClasses;
        public MembList Members;
    }
}
