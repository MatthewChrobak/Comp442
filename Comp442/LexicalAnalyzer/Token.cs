using System;

namespace LexicalAnalyzer
{
    public class Token
    {
        public TokenType Type { set; get; }
        public string TokenContent { get; set; } = String.Empty;
        public int? SourceLocation { get; set; } = null;
    }
}
