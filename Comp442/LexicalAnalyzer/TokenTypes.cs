namespace LexicalAnalyzer
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
        Invalid,
        EndOfStream,
        Comment
    }
}
