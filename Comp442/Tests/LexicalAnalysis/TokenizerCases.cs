using System;
using LexicalAnalyzer;
using LexicalAnalyzer.Models;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace Tests.LexicalAnalysis
{
    public class TokenizerTester
    {
        public void Test(string code, TokenType type)
        {
            this.Test(code, new TokenType[] { type });
        }

        public void Test(string code, TokenType[] expectedTokenTypes)
        {
            var tokenizer = new Tokenizer(code);
            string output = "\nExpected -> Given\n";
            int i = 0;

            foreach (var expectedTokenType in expectedTokenTypes) {
                var resultingToken = tokenizer.NextToken();
                output += $"{i++}: {expectedTokenType} -> {resultingToken?.Type}:{resultingToken?.TokenContent}\n";
                Assert.IsTrue(expectedTokenType == resultingToken?.Type, output);
            }

            // End of stream.
            var eosToken = tokenizer.NextToken();
            output += $"{i++}: {eosToken} -> {eosToken?.Type}:{eosToken?.TokenContent}";
            Assert.IsTrue(eosToken.Type == TokenType.EndOfStream, output);
        }
    }

    [TestClass]
    public class TokenizerCases : TokenizerTester
    {
        [TestMethod]
        public void AllTestCases()
        {
            Test("this 10.hello", new TokenType[] {
                TokenType.Identifier,
                TokenType.Integer,
                TokenType.DotOperator,
                TokenType.Identifier
            });
            Test("000.hello", new TokenType[] {
                TokenType.Integer,
                TokenType.Integer,
                TokenType.Integer,
                TokenType.DotOperator,
                TokenType.Identifier
            });
            Test("0.00hi", new TokenType[] {
                TokenType.Float,
                TokenType.Integer,
                TokenType.Identifier
            });
            Test("0.00000001hel 0.00000100", new TokenType[] {
                TokenType.Float,
                TokenType.Identifier,
                TokenType.Float,
                TokenType.Integer,
                TokenType.Integer
            });
            Test("1.1e 2.1e+ 3.1e- 4.1e0 5.1e+0 6.1e-0 7.1e++ 8.1e+104020", new TokenType[] {
                TokenType.Float,
                TokenType.Identifier,

                TokenType.Float,
                TokenType.Identifier,
                TokenType.ArithmaticOperator,

                TokenType.Float,
                TokenType.Identifier,
                TokenType.ArithmaticOperator,

                TokenType.Float,

                TokenType.Float,

                TokenType.Float,

                TokenType.Float,
                TokenType.Identifier,
                TokenType.ArithmaticOperator,
                TokenType.ArithmaticOperator,

                TokenType.Float
            });
            Test("===<<>><=>=;.,:::{}[]()*+/-", new TokenType[] {
                TokenType.Comparator,
                TokenType.AssignmentOperator,
                TokenType.Comparator,
                TokenType.Comparator,
                TokenType.Comparator,
                TokenType.Comparator,
                TokenType.Comparator,

                TokenType.Semicolon,
                TokenType.DotOperator,
                TokenType.Comma,

                TokenType.ScopeOperator,
                TokenType.Colon,

                TokenType.OpenCurlyBracket,
                TokenType.CloseCurlyBracket,

                TokenType.OpenBracket,
                TokenType.CloseBracket,

                TokenType.OpenParanthesis,
                TokenType.CloseParanthesis,
                TokenType.ArithmaticOperator,
                TokenType.ArithmaticOperator,
                TokenType.ArithmaticOperator,
                TokenType.ArithmaticOperator
            });
            Test("//This is a test\n/*this is a test*/", new TokenType[] {
                TokenType.Comment,
                TokenType.Comment,
            });
            Test("//EOF", TokenType.Comment);
            Test("/*EOF", TokenType.Comment);
        }
    }
}
