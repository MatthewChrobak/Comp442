using System;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class VarElement
    {
        public DataMember DataMember;
        public FCall FunctionCall;
    }
}
