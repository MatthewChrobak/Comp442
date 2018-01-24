using System;

namespace LexicalAnalyzer
{
    public class Token
    {
        public TokenType Type { set; get; }
        public string TokenContent { get; set; } = String.Empty;
        public int? SourceLocation { get; set; } = null;

        public static Token operator|(Token t1, Token t2)
        {
            if (t1 == null) {
                return t2;
            } else {
                return t1;
            }
        }
    }
}
