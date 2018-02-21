using System;
using System.Collections.Generic;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class AParams
    {
        public List<Expr> Expressions { get; set; }
    }
}
