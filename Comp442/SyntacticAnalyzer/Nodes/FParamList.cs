using System;
using System.Collections.Generic;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class FParamList
    {
        public List<FParam> Parameters { get; set; } = new List<FParam>();
    }
}
