using System;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class Program
    {
        public ClassList Classes { get; set; }
        public FuncDefList Functions { get; set; }
        public StatBlock MainFunction { get; set; }

        public override string ToString()
        {
            return Classes.ToString() + Functions.ToString() + "program" + MainFunction.ToString() + ";";
        }
    }
}
