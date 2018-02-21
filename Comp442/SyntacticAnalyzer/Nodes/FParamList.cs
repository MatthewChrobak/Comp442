using System.Collections.Generic;

namespace SyntacticAnalyzer.Nodes
{
    public class FParamList
    {
        public List<FParam> Parameters { get; set; } = new List<FParam>();
    }
}
