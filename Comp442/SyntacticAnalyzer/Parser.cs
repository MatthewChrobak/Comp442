using LexicalAnalyzer;
using LexicalAnalyzer.Models;
using SyntacticAnalyzer.Derivation;
using System;
using System.Linq;
using System.Text.RegularExpressions;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser : Deriver
    {
        private TokenStream _tokenStream;

        public Parser(string[] code)
        {
            this._tokenStream = new Tokenizer().Parse(code, true);
        }

        public bool Parse()
        {
            return Prog();
        }

        public bool Match(string atocc)
        {
            string tok = this._tokenStream.NextToken().AToCCFormat();
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

            if (formattedDerivation != this._tokenStream.FullAToCCFormat) {
                Console.WriteLine(formattedDerivation);
                Console.WriteLine(this._tokenStream.FullAToCCFormat);

                if (formattedDerivation.Length != this._tokenStream.FullAToCCFormat.Length) {
                    Console.WriteLine("Unequal length");
                    return false;
                }

                for (int i = 0; i < formattedDerivation.Length; i++) {
                    if (formattedDerivation[i] != this._tokenStream.FullAToCCFormat[i]) {
                        Console.WriteLine("Issue found at: " + i);
                    }
                }

                return false;
            }

            return true;
        }
    }
}
