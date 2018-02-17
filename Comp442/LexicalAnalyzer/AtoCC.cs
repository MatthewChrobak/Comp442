using System.Text;

namespace LexicalAnalyzer
{
    public class AtoCC
    {
        public string Convert(Token[] tokens)
        {
            var sb = new StringBuilder();

            foreach (var token in tokens) {
                switch (token.Type) {
                    case TokenType.ArithmaticOperator:
                        sb.Append(token.TokenContent);
                        break;
                    case TokenType.AssignmentOperator:
                        sb.Append("=");
                        break;
                    case TokenType.CloseBracket:
                        sb.Append("]");
                        break;
                    case TokenType.CloseCurlyBracket:
                        sb.Append("}");
                        break;
                    case TokenType.CloseParanthesis:
                        sb.Append(")");
                        break;
                    case TokenType.Colon:
                        sb.Append(":");
                        break;
                    case TokenType.Comma:
                        sb.Append(",");
                        break;
                    case TokenType.Comment:
                        continue;
                    case TokenType.Comparator:
                        switch (token.TokenContent) {
                            case ">":
                                sb.Append("gt");
                                break;
                            case "<":
                                sb.Append("lt");
                                break;
                            case ">=":
                                sb.Append("geq");
                                break;
                            case "<=":
                                sb.Append("leq");
                                break;
                            case "<>":
                                sb.Append("neq");
                                break;
                            case "==":
                                sb.Append("eq");
                                break;
                        }
                        break;
                    case TokenType.DotOperator:
                        sb.Append(".");
                        break;
                    case TokenType.EndOfStream:
                        continue;
                    case TokenType.Float:
                        sb.Append("floatNum");
                        break;
                    case TokenType.Identifier:
                        sb.Append("id");
                        break;
                    case TokenType.Integer:
                        sb.Append("intNum");
                        break;
                    case TokenType.InvalidCharacter:
                        continue;
                        throw new System.Exception("Invalid character");
                        
                    case TokenType.Keyword:
                        sb.Append(token.TokenContent);
                        break;
                    case TokenType.OpenBracket:
                        sb.Append("[");
                        break;
                    case TokenType.OpenCurlyBracket:
                        sb.Append("{");
                        break;
                    case TokenType.OpenParanthesis:
                        sb.Append("(");
                        break;
                    case TokenType.ScopeOperator:
                        sb.Append("sr");
                        break;
                    case TokenType.Semicolon:
                        sb.Append(";");
                        break;
                    case TokenType.Whitespace:
                        continue;
                }
            }

            return sb.ToString();
        }
    }
}
