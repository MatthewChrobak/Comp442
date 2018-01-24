using System;
using System.IO;
using LexicalAnalyzer;

namespace Assignment1
{
    public class Program
    {
        private const string _inputFile = "input.txt";

        static Program()
        {
            if (!File.Exists(_inputFile)) {
                File.Create(_inputFile).Close();
            }
        }

        private static void Main(string[] args)
        {
            var tokenizer = new Tokenizer(File.ReadAllText(_inputFile));

            Token token;
            do {
                token = tokenizer.NextToken();
                Console.Write($"[{token.Type}:{token.TokenContent}:{token.SourceLocation}] ");
            } while (token.Type != TokenType.EndOfStream);
            Console.WriteLine();

            Console.WriteLine("Press enter to continue...");
            Console.ReadLine();
        }
    }
}
