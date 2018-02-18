using LexicalAnalyzer;
using System.Collections.Generic;
using System.Linq;

namespace SyntacticAnalyzer
{
    public static class Extensions
    {
        public static bool HasToken(this string inputString, string AToCCToken)
        {
            return (inputString.Split().Contains(AToCCToken));
        }

        public static string DequeueAToCC(this Queue<Token> queue)
        {
            return AtoCC.Convert(queue.Dequeue());
        }
    }
}
