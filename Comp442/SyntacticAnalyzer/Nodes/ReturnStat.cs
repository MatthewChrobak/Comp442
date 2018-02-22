using System;
using System.Xml.Serialization;

namespace SyntacticAnalyzer.Nodes
{
    [Serializable]
    public class ReturnStat
    {
        public object ReturnValueExpression;
    }
}
