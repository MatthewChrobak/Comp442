namespace LexicalAnalyzer
{
    public static class Extensions
    {
        public static bool IsDigit(this char value)
        {
            return char.IsDigit(value);
        }

        public static bool IsLetter(this char value)
        {
            return char.IsLetter(value);
        }

        public static bool IsLetterOrDigit(this char value)
        {
            return char.IsLetterOrDigit(value);
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
    }
}
