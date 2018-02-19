using System.Linq;

namespace SyntacticAnalyzer
{
    public static class Extensions
    {
        public static bool HasToken(this string inputString, string AToCCToken)
        {
            return (inputString.Split().Contains(AToCCToken));
        }
    }
}
