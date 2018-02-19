using LexicalAnalyzer;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private Queue<Token> _tokenStream;
        private string _derivation = "prog";

        public Parser(string[] code)
        {
            var tokenizer = new Tokenizer(code);
            this._tokenStream = new Queue<Token>();

            Token token;
            do {
                token = tokenizer.NextRealToken();
                this._tokenStream.Enqueue(token);

                string atoccToken = AtoCC.Convert(token);
                Console.Write(atoccToken);
            } while (token.Type != TokenType.EndOfStream);

            Console.WriteLine("\n");
        }

        public bool Parse()
        {
            return Prog();
        }

        public bool Match(string atocc)
        {
            var tok = this._tokenStream.DequeueAToCC();
            var res = tok == atocc;

            if (!res) {
                Console.WriteLine($"\n\nWas expecting {atocc} and instead got {tok}\n");
            } else {
                Console.Write(atocc);
            }

            return res;
        }

        public void ApplyDerivation(string action)
        {
            var regex = new Regex(@"\-\>");
            var chunks = regex.Split(action).Select(val => val.Trim()).ToArray();

            regex = new Regex(chunks[0]);
            this._derivation = regex.Replace(this._derivation, chunks[1] == "EPSILON" ? string.Empty : chunks[1], 1).Replace("  ", " ").Trim();
        }

        public void WriteAndApplyDerivation(string action)
        {
            ApplyDerivation(action);
            WriteDerivation(action);
        }

        public void WriteDerivation(string action)
        {
            Console.WriteLine(this._derivation + "\t|\t" + action);
        }
    }
}
