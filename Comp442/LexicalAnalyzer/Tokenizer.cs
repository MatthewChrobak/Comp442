using LexicalAnalyzer.Models;
using LexicalAnalyzer.Scanners;
using System;
using System.Collections.Generic;
using System.Linq;

namespace LexicalAnalyzer
{
    public class Tokenizer
    {
        public List<string> Errors { private set; get; } = new List<string>();

        public TokenStream Parse(string[] characterStream, bool RealTokenStream = false)
        {
            this.Errors.Clear();

            var scanner = new Scanner(characterStream);
            var tokenStream = new Queue<Token>();

            Token token;
            do {
                token = RealTokenStream ? this.NextRealTokenFromScanner(scanner) : this.NextTokenFromScanner(scanner);
                tokenStream.Enqueue(token);
            } while (token.Type != TokenType.EndOfStream);

            return new TokenStream(tokenStream);
        }

        public TokenStream Parse(string characterStream, bool RealTokenStream = false)
        {
            return this.Parse(new string[] { characterStream }, RealTokenStream);
        }

        public string GetBootstrapReport()
        {
            throw new NotImplementedException();
        }

        private Token NextRealTokenFromScanner(Scanner scanner)
        {
            Token token;
            do {
                token = this.NextTokenFromScanner(scanner);
            } while (token.Type == TokenType.Comment);
            return token;
        }

        private Token NextTokenFromScanner(Scanner scanner)
        {
            this.RemoveWhitespacePrefixFromScanner(scanner);

            if (scanner.HasNextChar()) {
                char symbol = scanner.NextCharNoEx();
                string content = String.Empty;
                int startPos = scanner.CursorPosition.characterNumber - 1;

                // ID?
                if (symbol.IsLetter()) {
                    do {
                        content += symbol;
                        symbol = scanner.NextCharNoEx();
                    } while (symbol.IsLetterOrDigitOrUnderscore());
                    scanner.GoBack();

                    this.Errors.Add($"Invalid symbol in identifier sequence: '{symbol}' at {scanner.CursorPosition}");

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
                            symbol = scanner.NextCharNoEx();
                        } while (symbol.IsDigit());

                        if (symbol != '.') {
                            scanner.GoBack();
                            this.Errors.Add($"Invalid symbol in integer sequence: '{symbol}' at {scanner.CursorPosition}");
                            return new Token() { Type = TokenType.Integer, TokenContent = content, SourceLocation = startPos };
                        }
                    } else {
                        content += symbol;
                        symbol = scanner.NextCharNoEx();
                        if (symbol != '.') {
                            scanner.GoBack();
                            this.Errors.Add($"Invalid symbol in integer sequence: '{symbol}' at {scanner.CursorPosition}");
                            return new Token() { Type = TokenType.Integer, TokenContent = content, SourceLocation = startPos };
                        }
                    }

                    // The only way we get here is if we saw digit(s) followed by a '.'
                    
                    symbol = scanner.NextCharNoEx();

                    if (symbol.IsDigit()) {
                        // We know it's a float now. But we need to know how far.
                        content += '.';

                        if (!symbol.IsNonZero()) {
                            int counter = -1; // -1 because we need to add the first zero, which is guarenteed to be in the float. The trailing ones aren't.

                            do {
                                content += symbol;
                                symbol = scanner.NextCharNoEx();
                                counter++;
                            } while (symbol == '0');

                            // Did we see a non-digit? 
                            if (!symbol.IsNonZero()) {
                                scanner.GoBack(counter + 1); // + 1 to account for this new garbage character.
                                this.Errors.Add($"Invalid float in float sequence: '{symbol}' at {scanner.CursorPosition}");
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
                                scanner.GoBack();
                                this.Errors.Add($"Invalid symbol in float sequence: '{symbol}' at {scanner.CursorPosition}");
                                return new Token() { Type = TokenType.Float, TokenContent = content, SourceLocation = startPos };
                            }

                            if (symbol.IsNonZero()) {
                                content += symbol;
                                symbol = scanner.NextCharNoEx();
                                continue;
                            }

                            // We saw a zero.
                            int counter = 0; // This time start at 0, so that once we add it to the content, it'll be 1.

                            do {
                                content += symbol;
                                symbol = scanner.NextCharNoEx();
                                counter++;
                            } while (symbol == '0');

                            // Did we see a non-digit?
                            if (!symbol.IsNonZero()) {
                                scanner.GoBack(counter + 1); // + 1 to account for this new garbage character.
                                this.Errors.Add($"Invalid symbol in float sequence: '{symbol}' at {scanner.CursorPosition}");
                                content = content.Substring(0, content.Length - counter);
                                return new Token() { Type = TokenType.Float, TokenContent = content, SourceLocation = startPos };
                            }
                        }

                        string pad = String.Empty;
                        pad += symbol; // Add the 'e'
                        symbol = scanner.NextCharNoEx();

                        if (symbol.IsPlusOrMinus()) {
                            pad += symbol;
                            symbol = scanner.NextCharNoEx();
                        }

                        if (!symbol.IsDigit()) {
                            scanner.GoBack(pad.Length + 1);
                            this.Errors.Add($"Invalid symbol in float sequence: '{symbol}' at {scanner.CursorPosition}");
                            return new Token() { Type = TokenType.Float, TokenContent = content, SourceLocation = startPos };
                        }

                        if (symbol == '0') {
                            return new Token() { Type = TokenType.Float, TokenContent = content + pad + "0", SourceLocation = startPos };
                        }

                        do {
                            pad += symbol;
                            symbol = scanner.NextCharNoEx();
                        } while (symbol.IsDigit());
                        scanner.GoBack();

                        return new Token() { Type = TokenType.Float, TokenContent = content + pad, SourceLocation = startPos };

                    } else {
                        scanner.GoBack(2);
                        this.Errors.Add($"Invalid symbol in float sequence: '{symbol}' at {scanner.CursorPosition}");
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
                        if (scanner.NextCharNoEx() == ':') {
                            return new Token() { Type = TokenType.ScopeOperator, TokenContent = "::" };
                        } else {
                            scanner.GoBack();
                            this.Errors.Add($"Invalid symbol in :: sequence: '{symbol}' at {scanner.CursorPosition}\r\n");
                            return new Token() { Type = TokenType.Colon, TokenContent = symbol.ToString(), SourceLocation = startPos };
                        }
                    case '=':
                        if (scanner.NextCharNoEx() == '=') {
                            return new Token() { Type = TokenType.Comparator, TokenContent = "==" };
                        } else {
                            scanner.GoBack();
                            this.Errors.Add($"Invalid symbol in == sequence: '{symbol}' at {scanner.CursorPosition}");
                            return new Token() { Type = TokenType.AssignmentOperator, TokenContent = symbol.ToString(), SourceLocation = startPos };
                        }
                    case '>':
                        if (scanner.NextCharNoEx() == '=') {
                            return new Token() { Type = TokenType.Comparator, TokenContent = ">=" };
                        } else {
                            scanner.GoBack();
                            this.Errors.Add($"Invalid symbol in >= sequence: '{symbol}' at {scanner.CursorPosition}");
                            return new Token() { Type = TokenType.Comparator, TokenContent = symbol.ToString(), SourceLocation = startPos };
                        }
                    case '<': {
                        char next = scanner.NextCharNoEx();
                        switch (next) {
                            case '>':
                                return new Token() { Type = TokenType.Comparator, TokenContent = "<>", SourceLocation = startPos };
                            case '=':
                                return new Token() { Type = TokenType.Comparator, TokenContent = "<=", SourceLocation = startPos };
                            default:
                                scanner.GoBack();
                                this.Errors.Add($"Invalid symbol in <= or <> sequence: '{symbol}' at {scanner.CursorPosition}");
                                return new Token() { Type = TokenType.Comparator, TokenContent = symbol.ToString(), SourceLocation = startPos };
                        }
                    }
                    case '/': {
                        char next = scanner.NextCharNoEx();
                        switch (next) {
                            case '*':
                                content = "/*";
                                while (true) {
                                    symbol = scanner.NextCharNoEx();
                                    while (symbol != '*' && scanner.HasNextChar()) {
                                        content += symbol;
                                        symbol = scanner.NextCharNoEx();
                                    }
                                    // We know the previous is a * or EOF
                                    content += symbol;
                                    symbol = scanner.NextCharNoEx();

                                    // Is this a closing comment or the end of the file?
                                    if (symbol == '/') {
                                        content += symbol;
                                        return new Token() { Type = TokenType.Comment, TokenContent = content, SourceLocation = startPos };
                                    }

                                    if (!scanner.HasNextChar()) {
                                        return new Token() { Type = TokenType.Comment, TokenContent = content, SourceLocation = startPos };
                                    }

                                    content += symbol;
                                }
                                
                            case '/':
                                content = "/";
                                do {
                                    content += symbol;
                                    symbol = scanner.NextCharNoEx();
                                } while (symbol != '\n' && scanner.HasNextChar());

                                if (!scanner.HasNextChar()) {
                                    content += symbol;
                                }

                                return new Token() { Type = TokenType.Comment, TokenContent = content, SourceLocation = startPos };
                            default:
                                scanner.GoBack();
                                return new Token() { Type = TokenType.ArithmaticOperator, TokenContent = symbol.ToString(), SourceLocation = startPos };
                        }
                    }


                }
                this.Errors.Add($"Invalid symbol found '{symbol}' at {scanner.CursorPosition}");
                return new Token() { Type = TokenType.InvalidCharacter, TokenContent = symbol.ToString(), SourceLocation = startPos };
            }

            return new Token() { Type = TokenType.EndOfStream };
        }

        private void RemoveWhitespacePrefixFromScanner(Scanner scanner)
        {
            while (scanner.HasNextChar()) {
                if (!Char.IsWhiteSpace(scanner.NextChar())) {
                    scanner.PrevChar();
                    break;
                }
            }
        }
    }
}
