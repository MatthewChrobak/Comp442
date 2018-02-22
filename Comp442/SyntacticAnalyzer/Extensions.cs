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

        public static void JoinListWhereNotNull<T>(this List<T> list, IEnumerable<T> joiningList)
        {
            if (joiningList != null) {
                list.AddRange(joiningList.Where(val => val != null));
            }
        }

        public static void AddIfNotNull<T>(this List<T> list, T value)
        {
            if (value != null) {
                list.Add(value);
            }
        }
    }
}
