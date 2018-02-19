using LexicalAnalyzer;
using LexicalAnalyzer.Models;
using SyntacticAnalyzer.Derivation;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser : Deriver
    {
        private Queue<Token> _tokenStream;
        public string ProgramTokenStream_AToCC;

        public Parser(string[] code)
        {
            var tokenizer = new Tokenizer(code);
            this._tokenStream = new Queue<Token>();
            var sb = new StringBuilder();

            Token token;
            do {
                token = tokenizer.NextRealToken();
                this._tokenStream.Enqueue(token);
                sb.Append(token.AToCC());
            } while (token.Type != TokenType.EndOfStream);

            this.ProgramTokenStream_AToCC = sb.ToString();
        }

        public bool Parse()
        {
            return Prog();
        }

        public bool Match(string atocc)
        {
            string tok = this._tokenStream.DequeueAToCC();
            bool res = tok == atocc;

            if (!res) {
                Console.WriteLine($"\n\nWas expecting {atocc} and instead got {tok}\n");
            }

            return res;
        }

        public bool Verify()
        {
            var regex = new Regex(@"\s+|\'");
            string formattedDerivation = regex.Replace(this.Derivations.Last().Derivation, String.Empty);
            
            if (formattedDerivation.Length != this.ProgramTokenStream_AToCC.Length) {
                return false;
            }

            for (int i = 0; i < formattedDerivation.Length; i++) {
                if (formattedDerivation[i] != this.ProgramTokenStream_AToCC[i]) {
                    Console.WriteLine(i);
                }
            }

            Console.WriteLine(formattedDerivation);
            Console.WriteLine(this.ProgramTokenStream_AToCC);
            return formattedDerivation == this.ProgramTokenStream_AToCC;
        }
    }
}
