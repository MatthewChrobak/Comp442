using LexicalAnalyzer;
using SyntacticAnalyzer.Derivation;
using System;
using System.Collections.Generic;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser : Deriver
    {
        private Queue<Token> _tokenStream;

        public Parser(string[] code)
        {
            var tokenizer = new Tokenizer(code);
            this._tokenStream = new Queue<Token>();

            Token token;
            do {
                token = tokenizer.NextRealToken();
                this._tokenStream.Enqueue(token);
            } while (token.Type != TokenType.EndOfStream);
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
            }

            return res;
        }
    }
}
