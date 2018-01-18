using System;

namespace LexicalAnalyzer
{
    public class Token
    {
        public TokenType Type { set; get; }
        public string TokenContent { get; set; } = String.Empty;
        public (uint lineNumber, uint characterNumber) SourceLocation { get; set; }

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
