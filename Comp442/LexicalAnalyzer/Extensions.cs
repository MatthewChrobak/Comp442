using LexicalAnalyzer.Models;
using System;
using System.Text;

namespace LexicalAnalyzer
{
    public static class Extensions
    {
        public static bool IsDigit(this char value)
        {
            return Char.IsDigit(value);
        }

        public static bool IsLetter(this char value)
        {
            return Char.IsLetter(value);
        }

        public static bool IsLetterOrDigit(this char value)
        {
            return Char.IsLetterOrDigit(value);
        }

        public static bool IsLetterOrDigitOrUnderscore(this char value)
        {
            return value == '_' || value.IsLetterOrDigit();
        }

        public static bool IsNonZero(this char value)
        {
            return value != '0' && value.IsDigit();
        }

        public static bool IsPlusOrMinus(this char value)
        {
            return value == '+' || value == '-';
        }

        public static string AToCC(this Token[] tokens)
        {
            var sb = new StringBuilder();

            foreach (var token in tokens) {
                sb.Append(token.AToCC());
            }

            return sb.ToString();
        }
    }
}
