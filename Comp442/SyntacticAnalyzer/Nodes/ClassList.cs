using System.Collections.Generic;

namespace SyntacticAnalyzer.Nodes
{
    public class ClassList
    {
        public List<ClassDecl> Classes { get; set; } = new List<ClassDecl>();
    }
}
