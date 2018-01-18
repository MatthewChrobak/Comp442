using System;
using System.Linq;

namespace LexicalAnalyzer
{
    public class Tokenizer : Scanner
    {
        public Tokenizer(string characterStream) : base(characterStream)
        {

        }

        public Token NextToken()
        {
            this.RemoveWhitespacePrefix();

            if (this.HasNextChar()) {
                char symbol = this.NextCharNoEx();
                string content = string.Empty;

                // ID?
                if (symbol.IsLetter()) {
                    do {
                        content += symbol;
                        symbol = this.NextCharNoEx();
                    } while (symbol.IsLetterOrDigitOrUnderscore());
                    this.GoBack();

                    if (Language.Language_Keywords.Contains(content)) {
                        return new Token() { Type = TokenType.Keyword, TokenContent = content };
                    }

                    return new Token() { Type = TokenType.Identifier, TokenContent = content };
                }

                // Number?
                if (symbol.IsDigit()) {
                    if (symbol.IsNonZero()) {

                        do {
                            content += symbol;
                            symbol = this.NextCharNoEx();
                        } while (symbol.IsDigit());

                        if (symbol != '.') {
                            this.GoBack();
                            return new Token() { Type = TokenType.Integer, TokenContent = content };
                        }
                    } else {
                        content += symbol;
                        symbol = this.NextCharNoEx();
                        if (symbol != '.') {
                            this.GoBack();
                            return new Token() { Type = TokenType.Integer, TokenContent = content };
                        }
                    }

                    // The only way we get here is if we saw digit(s) followed by a '.'
                    
                    symbol = this.NextCharNoEx();

                    if (symbol.IsDigit()) {
                        // We know it's a float now. But we need to know how far.
                        content += '.';

                        if (!symbol.IsNonZero()) {
                            int counter = -1; // -1 because we need to add the first zero, which is guarenteed to be in the float. The trailing ones aren't.

                            do {
                                content += symbol;
                                symbol = this.NextCharNoEx();
                                counter++;
                            } while (symbol == '0');

                            // Did we see a non-digit? 
                            if (!symbol.IsNonZero()) {
                                this.GoBack(counter + 1); // + 1 to account for this new garbage character.
                                content = content.Substring(0, content.Length - counter);
                                return new Token() { Type = TokenType.Float, TokenContent = content };
                            }
                        }

                        // We've seen a nonzero at some point.
                        // Keep reading and handling 0's and 1's.
                        while (true) {

                            // Read the e?
                            if (symbol == 'e') {
                                break;
                            }

                            if (!symbol.IsDigit()) {
                                this.GoBack();
                                return new Token() { Type = TokenType.Float, TokenContent = content };
                            }

                            if (symbol.IsNonZero()) {
                                content += symbol;
                                symbol = this.NextCharNoEx();
                                continue;
                            }

                            // We saw a zero.
                            int counter = 0; // This time start at 0, so that once we add it to the content, it'll be 1.

                            do {
                                content += symbol;
                                symbol = this.NextCharNoEx();
                                counter++;
                            } while (symbol == '0');

                            // Did we see a non-digit?
                            if (!symbol.IsNonZero()) {
                                this.GoBack(counter + 1); // + 1 to account for this new garbage character.
                                content = content.Substring(0, content.Length - counter);
                                return new Token() { Type = TokenType.Float, TokenContent = content };
                            }
                        }

                        string pad = string.Empty;
                        pad += symbol; // Add the 'e'
                        symbol = this.NextCharNoEx();

                        if (symbol.IsPlusOrMinus()) {
                            pad += symbol;
                            symbol = this.NextCharNoEx();
                        }

                        if (!symbol.IsDigit()) {
                            this.GoBack(pad.Length + 1);
                            return new Token() { Type = TokenType.Float, TokenContent = content };
                        }

                        if (symbol == '0') {
                            return new Token() { Type = TokenType.Float, TokenContent = content + pad + "0" };
                        }

                        do {
                            pad += symbol;
                            symbol = this.NextCharNoEx();
                        } while (symbol.IsDigit());
                        this.GoBack();

                        return new Token() { Type = TokenType.Float, TokenContent = content + pad };

                    } else {
                        this.GoBack(2);
                        return new Token() { Type = TokenType.Integer, TokenContent = content };
                    }
                }

                switch (symbol) {
                    case '.':
                        return new Token() { Type = TokenType.DotOperator, TokenContent = "." };
                    case '+':
                    case '-':
                    case '*':
                        return new Token() { Type = TokenType.ArithmaticOperator, TokenContent = symbol.ToString() };
                    case '(':
                        return new Token() { Type = TokenType.OpenParanthesis, TokenContent = symbol.ToString() };
                    case ')':
                        return new Token() { Type = TokenType.CloseParanthesis, TokenContent = symbol.ToString() };
                    case ',':
                        return new Token() { Type = TokenType.Comma, TokenContent = symbol.ToString() };
                    case ';':
                        return new Token() { Type = TokenType.Semicolon, TokenContent = symbol.ToString() };
                    case '[':
                        return new Token() { Type = TokenType.OpenBracket, TokenContent = symbol.ToString() };
                    case ']':
                        return new Token() { Type = TokenType.CloseBracket, TokenContent = symbol.ToString() };
                    case '{':
                        return new Token() { Type = TokenType.OpenCurlyBracket, TokenContent = symbol.ToString() };
                    case '}':
                        return new Token() { Type = TokenType.CloseCurlyBracket, TokenContent = symbol.ToString() };
                    case ':':
                        if (this.NextCharNoEx() == ':') {
                            return new Token() { Type = TokenType.ScopeOperator, TokenContent = "::" };
                        } else {
                            this.GoBack();
                            return new Token() { Type = TokenType.Colon, TokenContent = symbol.ToString() };
                        }
                    case '=':
                        if (this.NextCharNoEx() == '=') {
                            return new Token() { Type = TokenType.Comparator, TokenContent = "==" };
                        } else {
                            this.GoBack();
                            return new Token() { Type = TokenType.AssignmentOperator, TokenContent = symbol.ToString() };
                        }
                    case '>':
                        if (this.NextCharNoEx() == '=') {
                            return new Token() { Type = TokenType.Comparator, TokenContent = ">=" };
                        } else {
                            this.GoBack();
                            return new Token() { Type = TokenType.Comparator, TokenContent = symbol.ToString() };
                        }
                    case '<': {
                        char next = this.NextCharNoEx();
                        switch (next) {
                            case '>':
                                return new Token() { Type = TokenType.Comparator, TokenContent = "<>" };
                            case '=':
                                return new Token() { Type = TokenType.Comparator, TokenContent = "<=" };
                            default:
                                this.GoBack();
                                return new Token() { Type = TokenType.Comparator, TokenContent = symbol.ToString() };
                        }
                    }
                    case '/': {
                        char next = this.NextCharNoEx();
                        switch (next) {
                            case '*':
                                content = "/*";
                                while (true) {
                                    symbol = this.NextCharNoEx();
                                    while (symbol != '*' && this.HasNextChar()) {
                                        content += symbol;
                                        symbol = this.NextCharNoEx();
                                    }
                                    // We know the previous is a * or EOF
                                    content += symbol;
                                    symbol = this.NextCharNoEx();

                                    // Is this a closing comment or the end of the file?
                                    if (symbol == '/') {
                                        content += symbol;
                                        return new Token() { Type = TokenType.Comment, TokenContent = content };
                                    }

                                    if (!this.HasNextChar()) {
                                        return new Token() { Type = TokenType.Comment, TokenContent = content };
                                    }

                                    content += symbol;
                                }
                                
                            case '/':
                                content = "/";
                                do {
                                    content += symbol;
                                    symbol = this.NextCharNoEx();
                                } while (symbol != '\n' && this.HasNextChar());

                                if (!this.HasNextChar()) {
                                    content += symbol;
                                }

                                return new Token() { Type = TokenType.Comment, TokenContent = content };
                            default:
                                this.GoBack();
                                return new Token() { Type = TokenType.ArithmaticOperator, TokenContent = symbol.ToString() };
                        }
                    }


                }

                return new Token() { Type = TokenType.Invalid, TokenContent = symbol.ToString() };
            }

            return new Token() { Type = TokenType.EndOfStream };
        }

        private void RemoveWhitespacePrefix()
        {
            while (this.HasNextChar()) {
                if (!Char.IsWhiteSpace(this.NextChar())) {
                    this.PrevChar();
                    break;
                }
            }
        }
    }
}
