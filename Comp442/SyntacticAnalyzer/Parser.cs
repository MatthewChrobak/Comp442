using LexicalAnalyzer;
using LexicalAnalyzer.Models;
using ReportGenerator;
using SyntacticAnalyzer.Derivation;
using SyntacticAnalyzer.Nodes;
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
        private Prog AST;

        public Parser(string[] code)
        {
            this._tokenizer = new Tokenizer();

            this.TokenStream = this._tokenizer.Parse(code, true);
        }

        public Prog Parse()
        {
            this.AST = Prog();
            return this.AST;
        }

        private string Match(string atocc)
        {
            var token = this.TokenStream.Peek();
            string token_AToCC = token.AToCCFormat();

            if (token_AToCC != atocc) {
                if (token.Type == TokenType.EndOfStream) {
                    this.Errors.Add($"Unexpected end of file at {token.SourceLocation}. Expected {atocc}");
                } else {
                    this.Errors.Add($"Expected {atocc} - '{token.SourceLocation}'. Got '{token.TokenContent}'.");
                }
            } else {
                this.TokenStream.NextToken();
            }

            return token.TokenContent;
        }

        public bool Verify()
        {
            string formattedDerivation = Regex.Replace(this.Derivations.Last().SententialForm, @"\s+|\'", String.Empty);
            return this.Errors.Count == 0 && formattedDerivation == this.TokenStream.FullAToCCFormat;
        }
        
        private void SkipErrors(string first, string follow, bool hasEpsilonProduction = true)
        {
            Token token;
            string lookahead;

            do {
                token = this.TokenStream.Peek();
                lookahead = token.AToCCFormat();

                if (first.HasToken(lookahead) || (hasEpsilonProduction && follow.HasToken(lookahead))) {
                    return;
                }

                this.Errors.Add($"Expected {(first + " " + follow).Trim().Replace(" ", ", ")} - {token.SourceLocation}. Got '{token.TokenContent}'.");
                this.TokenStream.NextToken(); // Disregard this current token.

            } while (token.Type != TokenType.EndOfStream);
        }

        private void SkipErrors(string first)
        {
            this.SkipErrors(first, String.Empty, false);
        }
    }
}
