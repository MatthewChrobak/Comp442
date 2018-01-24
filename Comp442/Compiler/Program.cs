using LexicalAnalyzer;
using System;

namespace Compiler
{
    public class Program
    {
        private static void Main(string[] args)
        {
            while (true) {
                string input = Console.ReadLine();
                var tokenizer = new Tokenizer(input);

                Token token;

                do {
                    token = tokenizer.NextToken();
                    Console.Write($"[{token.Type}:{token.TokenContent}:{token.SourceLocation}] ");
                } while (token.Type != TokenType.EndOfStream);
                Console.WriteLine();
            }
            
        }
    }
}
