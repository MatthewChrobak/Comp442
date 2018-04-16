using System;

namespace LexicalAnalyzer.Models
{
    public class Token
    {
        public TokenType Type { set; get; }
        public string TokenContent { get; set; } = String.Empty;
        public (int lineNumber, int characterNumber) SourceLocation { get; set; }

        public string AToCCFormat()
        {
            switch (this.Type) {
                case TokenType.EndOfStream:
                    return "$";

                case TokenType.ArithmaticOperator:
                    return (this.TokenContent);

                case TokenType.AssignmentOperator:
                    return ("=");

                case TokenType.CloseBracket:
                    return ("]");

                case TokenType.CloseCurlyBracket:
                    return ("}");

                case TokenType.CloseParanthesis:
                    return (")");

                case TokenType.Colon:
                    return (":");

                case TokenType.Comma:
                    return (",");

                case TokenType.Comparator:
                    switch (this.TokenContent) {
                        case ">":
                            return ("gt");

                        case "<":
                            return ("lt");

                        case ">=":
                            return ("geq");

                        case "<=":
                            return ("leq");

                        case "<>":
                            return ("neq");

                        case "==":
                            return ("eq");
                    }
                    break;

                case TokenType.DotOperator:
                    return (".");

                case TokenType.Float:
                    return ("floatNum");

                case TokenType.Identifier:
                    return ("id");

                case TokenType.Integer:
                    return ("intNum");

                case TokenType.InvalidCharacter:
                    return "�";

                case TokenType.Keyword:
                    return (this.TokenContent);

                case TokenType.OpenBracket:
                    return ("[");

                case TokenType.OpenCurlyBracket:
                    return ("{");

                case TokenType.OpenParanthesis:
                    return ("(");

                case TokenType.ScopeOperator:
                    return ("sr");

                case TokenType.Semicolon:
                    return (";");
                case TokenType.Comment:
                    return "Comment";
            }

            return String.Empty;
        }
    }
}
