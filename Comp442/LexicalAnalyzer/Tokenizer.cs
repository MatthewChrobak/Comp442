using LexicalAnalyzer.Models;
using LexicalAnalyzer.Scanners;
using System;
using System.Collections.Generic;
using System.Linq;

namespace LexicalAnalyzer
{
    public class Tokenizer : Scanner
    {
        public List<string> Errors { private set; get; } = new List<string>();

        public Tokenizer(string characterStream) : base(characterStream)
        {

        }

        public Tokenizer(string[] characterStream) : base(characterStream)
        {

        }

        public string GetBootstrapReport()
        {
            throw new NotImplementedException();
        }

        public Token NextRealToken()
        {
            Token token;
            do {
                token = this.NextToken();
            } while (token.Type == TokenType.Comment);
            return token;
        }

        public Token NextToken()
        {
            this.RemoveWhitespacePrefix();

            if (this.HasNextChar()) {
                char symbol = this.NextCharNoEx();
                string content = String.Empty;
                int startPos = this.CursorPosition.characterNumber - 1;

                // ID?
                if (symbol.IsLetter()) {
                    do {
                        content += symbol;
                        symbol = this.NextCharNoEx();
                    } while (symbol.IsLetterOrDigitOrUnderscore());
                    this.GoBack();

                    this.Errors.Add($"Invalid symbol in identifier sequence: '{symbol}' at {this.CursorPosition}");

                    if (Language.Keywords.Contains(content)) {
                        return new Token() { Type = TokenType.Keyword, TokenContent = content, SourceLocation = startPos };
                    }

                    return new Token() { Type = TokenType.Identifier, TokenContent = content, SourceLocation = startPos };
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
                            this.Errors.Add($"Invalid symbol in integer sequence: '{symbol}' at {this.CursorPosition}");
                            return new Token() { Type = TokenType.Integer, TokenContent = content, SourceLocation = startPos };
                        }
                    } else {
                        content += symbol;
                        symbol = this.NextCharNoEx();
                        if (symbol != '.') {
                            this.GoBack();
                            this.Errors.Add($"Invalid symbol in integer sequence: '{symbol}' at {this.CursorPosition}");
                            return new Token() { Type = TokenType.Integer, TokenContent = content, SourceLocation = startPos };
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
                                this.Errors.Add($"Invalid float in float sequence: '{symbol}' at {this.CursorPosition}");
                                content = content.Substring(0, content.Length - counter);
                                return new Token() { Type = TokenType.Float, TokenContent = content, SourceLocation = startPos };
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
                                this.Errors.Add($"Invalid symbol in float sequence: '{symbol}' at {this.CursorPosition}");
                                return new Token() { Type = TokenType.Float, TokenContent = content, SourceLocation = startPos };
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
                                this.Errors.Add($"Invalid symbol in float sequence: '{symbol}' at {this.CursorPosition}");
                                content = content.Substring(0, content.Length - counter);
                                return new Token() { Type = TokenType.Float, TokenContent = content, SourceLocation = startPos };
                            }
                        }

                        string pad = String.Empty;
                        pad += symbol; // Add the 'e'
                        symbol = this.NextCharNoEx();

                        if (symbol.IsPlusOrMinus()) {
                            pad += symbol;
                            symbol = this.NextCharNoEx();
                        }

                        if (!symbol.IsDigit()) {
                            this.GoBack(pad.Length + 1);
                            this.Errors.Add($"Invalid symbol in float sequence: '{symbol}' at {this.CursorPosition}");
                            return new Token() { Type = TokenType.Float, TokenContent = content, SourceLocation = startPos };
                        }

                        if (symbol == '0') {
                            return new Token() { Type = TokenType.Float, TokenContent = content + pad + "0", SourceLocation = startPos };
                        }

                        do {
                            pad += symbol;
                            symbol = this.NextCharNoEx();
                        } while (symbol.IsDigit());
                        this.GoBack();

                        return new Token() { Type = TokenType.Float, TokenContent = content + pad, SourceLocation = startPos };

                    } else {
                        this.GoBack(2);
                        this.Errors.Add($"Invalid symbol in float sequence: '{symbol}' at {this.CursorPosition}");
                        return new Token() { Type = TokenType.Integer, TokenContent = content, SourceLocation = startPos };
                    }
                }

                switch (symbol) {
                    case '.':
                        return new Token() { Type = TokenType.DotOperator, TokenContent = ".", SourceLocation = startPos };
                    case '+':
                    case '-':
                    case '*':
                        return new Token() { Type = TokenType.ArithmaticOperator, TokenContent = symbol.ToString(), SourceLocation = startPos };
                    case '(':
                        return new Token() { Type = TokenType.OpenParanthesis, TokenContent = symbol.ToString(), SourceLocation = startPos };
                    case ')':
                        return new Token() { Type = TokenType.CloseParanthesis, TokenContent = symbol.ToString(), SourceLocation = startPos };
                    case ',':
                        return new Token() { Type = TokenType.Comma, TokenContent = symbol.ToString(), SourceLocation = startPos };
                    case ';':
                        return new Token() { Type = TokenType.Semicolon, TokenContent = symbol.ToString(), SourceLocation = startPos };
                    case '[':
                        return new Token() { Type = TokenType.OpenBracket, TokenContent = symbol.ToString(), SourceLocation = startPos };
                    case ']':
                        return new Token() { Type = TokenType.CloseBracket, TokenContent = symbol.ToString(), SourceLocation = startPos };
                    case '{':
                        return new Token() { Type = TokenType.OpenCurlyBracket, TokenContent = symbol.ToString(), SourceLocation = startPos };
                    case '}':
                        return new Token() { Type = TokenType.CloseCurlyBracket, TokenContent = symbol.ToString(), SourceLocation = startPos };
                    case ':':
                        if (this.NextCharNoEx() == ':') {
                            return new Token() { Type = TokenType.ScopeOperator, TokenContent = "::" };
                        } else {
                            this.GoBack();
                            this.Errors.Add($"Invalid symbol in :: sequence: '{symbol}' at {this.CursorPosition}\r\n");
                            return new Token() { Type = TokenType.Colon, TokenContent = symbol.ToString(), SourceLocation = startPos };
                        }
                    case '=':
                        if (this.NextCharNoEx() == '=') {
                            return new Token() { Type = TokenType.Comparator, TokenContent = "==" };
                        } else {
                            this.GoBack();
                            this.Errors.Add($"Invalid symbol in == sequence: '{symbol}' at {this.CursorPosition}");
                            return new Token() { Type = TokenType.AssignmentOperator, TokenContent = symbol.ToString(), SourceLocation = startPos };
                        }
                    case '>':
                        if (this.NextCharNoEx() == '=') {
                            return new Token() { Type = TokenType.Comparator, TokenContent = ">=" };
                        } else {
                            this.GoBack();
                            this.Errors.Add($"Invalid symbol in >= sequence: '{symbol}' at {this.CursorPosition}");
                            return new Token() { Type = TokenType.Comparator, TokenContent = symbol.ToString(), SourceLocation = startPos };
                        }
                    case '<': {
                        char next = this.NextCharNoEx();
                        switch (next) {
                            case '>':
                                return new Token() { Type = TokenType.Comparator, TokenContent = "<>", SourceLocation = startPos };
                            case '=':
                                return new Token() { Type = TokenType.Comparator, TokenContent = "<=", SourceLocation = startPos };
                            default:
                                this.GoBack();
                                this.Errors.Add($"Invalid symbol in <= or <> sequence: '{symbol}' at {this.CursorPosition}");
                                return new Token() { Type = TokenType.Comparator, TokenContent = symbol.ToString(), SourceLocation = startPos };
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
                                        return new Token() { Type = TokenType.Comment, TokenContent = content, SourceLocation = startPos };
                                    }

                                    if (!this.HasNextChar()) {
                                        return new Token() { Type = TokenType.Comment, TokenContent = content, SourceLocation = startPos };
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

                                return new Token() { Type = TokenType.Comment, TokenContent = content, SourceLocation = startPos };
                            default:
                                this.GoBack();
                                return new Token() { Type = TokenType.ArithmaticOperator, TokenContent = symbol.ToString(), SourceLocation = startPos };
                        }
                    }


                }
                this.Errors.Add($"Invalid symbol found '{symbol}' at {this.CursorPosition}");
                return new Token() { Type = TokenType.InvalidCharacter, TokenContent = symbol.ToString(), SourceLocation = startPos };
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
