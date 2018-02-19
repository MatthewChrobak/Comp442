using LexicalAnalyzer;
using LexicalAnalyzer.Models;
using System;
using System.Collections.Generic;
using System.IO;

namespace Assignment1
{
    public class Program
    {
        private static void Main(string[] args)
        {
            while (true) {
                Console.Write("Please enter a filename for input: ");
                string file = Console.ReadLine();

                if (!File.Exists(file)) {
                    Console.WriteLine("File does not exist.");
                    continue;
                }

                Console.WriteLine();
                var tokenizer = new Tokenizer(File.ReadAllLines(file));

                var tokens = new List<Token>();

                Token token;
                do {
                    token = tokenizer.NextToken();
                    tokens.Add(token);
                    Console.Write($"[{token.Type}:{token.TokenContent.Replace("\n", "\\n")}:{token.SourceLocation}] ");
                } while (token.Type != TokenType.EndOfStream);
                Console.WriteLine("\n");

                //tokenizer.Dispose(new FileInfo(file).Name.Replace(".", "_report."));

                File.WriteAllText(new FileInfo(file).Name.Replace(".", "_AtoCC."), tokens.ToArray().AToCC());
            }
        }
    }

}
