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
        private bool _hitEndOfFile = false;
        public Program AbstractSyntaxTree { get; private set; }

        public Parser(string[] code)
        {
            this._tokenizer = new Tokenizer();

            this.TokenStream = this._tokenizer.Parse(code, true);
        }

        public Program Parse()
        {
            this.AbstractSyntaxTree = Prog();
            return this.AbstractSyntaxTree;
        }

        private string Match(string atocc)
        {
            var token = this.TokenStream.Peek();
            string token_AToCC = token.AToCCFormat();

            if (!this._hitEndOfFile) {
                if (token_AToCC != atocc) {
                    if (token.Type == TokenType.EndOfStream) {
                        this.Errors.Add($"Unexpected end of file at {token.SourceLocation}. Expected {atocc}");
                        this._hitEndOfFile = true;
                    } else {
                        this.Errors.Add($"Expected {atocc} - '{token.SourceLocation}'. Got '{token.TokenContent}'.");
                    }
                } else {
                    this.TokenStream.NextToken();
                }
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
            bool errorReported = false;

            do {
                token = this.TokenStream.Peek();
                lookahead = token.AToCCFormat();

                if (token.Type == TokenType.EndOfStream) {
                    break;
                }

                if (first.HasToken(lookahead) || (hasEpsilonProduction && follow.HasToken(lookahead))) {
                    return;
                }

                if (!errorReported) {
                    this.Errors.Add($"Expected {(first + " " + follow).Trim().Replace(" ", ", ")} - {token.SourceLocation}. Got '{token.TokenContent}'.");
                    errorReported = true;
                }

                this.TokenStream.NextToken(); // Disregard this current token.

            } while (token.Type != TokenType.EndOfStream);
        }

        private void SkipErrors(string first)
        {
            this.SkipErrors(first, String.Empty, false);
        }
    }
}
