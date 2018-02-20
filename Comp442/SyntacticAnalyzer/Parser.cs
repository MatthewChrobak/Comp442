using LexicalAnalyzer;
using LexicalAnalyzer.Models;
using ReportGenerator;
using SyntacticAnalyzer.Derivation;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser : Deriver, IReportable
    {
        public TokenStream TokenStream { get; set; }
        private Tokenizer _tokenizer;
        private List<string> Errors = new List<string>();

        public Parser(string[] code)
        {
            this._tokenizer = new Tokenizer();

            this.TokenStream = this._tokenizer.Parse(code, true);
        }

        public bool Parse()
        {
            if (Prog()) {

                if (Match("$")) {
                    return true;
                }
            }

            return false;
        }

        private bool Match(string atocc)
        {
            var token = this.TokenStream.NextToken();
            string token_AToCC = token.AToCCFormat();
            bool res = token_AToCC == atocc;

            if (!res) {

                if (token.Type == TokenType.EndOfStream) {
                    this.Errors.Add($"Unexpected end of file at {token.SourceLocation}. Expected {atocc}");
                } else {
                    this.Errors.Add($"Syntax error '{token.TokenContent}' at {token.SourceLocation}. Expected {atocc}");
                }
            }

            return res;
        }

        public bool Verify()
        {
            string formattedDerivation = Regex.Replace(this.Derivations.Last().SententialForm, @"\s+|\'", String.Empty);
            return formattedDerivation == this.TokenStream.FullAToCCFormat;
        }
        
    }
}
