namespace LexicalAnalyzer.Models
{
    public enum TokenType
    {
        Identifier,
        Integer,
        Float,
        Whitespace,
        ArithmaticOperator,
        Comparator,
        Semicolon,
        Comma,
        DotOperator,
        Colon,
        ScopeOperator,
        AssignmentOperator,
        OpenParanthesis,
        CloseParanthesis,
        OpenBracket,
        CloseBracket,
        OpenCurlyBracket,
        CloseCurlyBracket,
        Keyword,
        InvalidCharacter,
        EndOfStream,
        Comment
    }
}
