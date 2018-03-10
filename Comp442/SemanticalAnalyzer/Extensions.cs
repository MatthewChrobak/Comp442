using System.Text;

namespace SemanticalAnalyzer
{
    public static class Extensions
    {
        public static string Repeat(this string value, int count)
        {
            var sb = new StringBuilder();

            for (int i = 0; i < count; i++) {
                sb.Append(value);
            }

            return sb.ToString();
        }
    }
}
