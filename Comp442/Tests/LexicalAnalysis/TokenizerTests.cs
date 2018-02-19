using LexicalAnalyzer;
using LexicalAnalyzer.Models;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;

namespace Tests.LexicalAnalysis
{
    [TestClass]
    public class TokenizerTests
    {
        [TestMethod]
        public void NextToken_EmptyString_NullToken()
        {
            var tokenStream = new Tokenizer().Parse(String.Empty);
            Assert.IsTrue(tokenStream.NextToken()?.Type == TokenType.EndOfStream);
        }

        [TestMethod]
        public void NextToken_RandomString_NotNullToken()
        {
            var tokenStream = new Tokenizer().Parse("test");
            Assert.IsTrue(tokenStream.NextToken()?.Type != TokenType.EndOfStream);
        }

        [TestMethod]
        public void NextToken_TextIdentifier_Found()
        {
            var tokenStream = new Tokenizer().Parse("hello world");
            var token = tokenStream.NextToken();

            Assert.IsTrue(token.Type == TokenType.Identifier, token.Type.ToString());
            Assert.IsTrue(token.TokenContent == "hello", token.TokenContent);

            token = tokenStream.NextToken();
            Assert.IsTrue(token.Type == TokenType.Identifier, token.Type.ToString());
            Assert.IsTrue(token.TokenContent == "world", token.TokenContent);
        }

        [TestMethod]
        public void NextToken_TextDigitIdentifier_Found()
        {
            var tokenStream = new Tokenizer().Parse("hello12 world12");
            var token = tokenStream.NextToken();

            Assert.IsTrue(token.Type == TokenType.Identifier, token.Type.ToString());
            Assert.IsTrue(token.TokenContent == "hello12", token.TokenContent);

            token = tokenStream.NextToken();
            Assert.IsTrue(token.Type == TokenType.Identifier, token.Type.ToString());
            Assert.IsTrue(token.TokenContent == "world12", token.TokenContent);
        }

        [TestMethod]
        public void NextToken_AllKeywords_Found()
        {
            var tokenStream = new Tokenizer().Parse(String.Join(" ", Language.Keywords));
            for (int i = 0; i < Language.Keywords.Length; i++) {
                var token = tokenStream.NextToken();

                Assert.IsNotNull(token, "Null token");
                Assert.IsTrue(token.Type == TokenType.Keyword, $"{i}: {token.Type.ToString()}");
                Assert.IsTrue(token.TokenContent == Language.Keywords[i], $"{i}: {token.TokenContent}");
            }
        }

        [TestMethod]
        public void NextToken_ConsecutiveZeros_Found()
        {
            string testString = "000000000000000000000000";
            var tokenStream = new Tokenizer().Parse(testString);
            for (int i = 0; i < testString.Length; i++) {
                var token = tokenStream.NextToken();

                Assert.IsNotNull(token);
                Assert.IsTrue(token.Type == TokenType.Integer);
                Assert.IsTrue(token.TokenContent == "0");
            }
        }

        [TestMethod]
        public void NextToken_Integers_Found()
        {
            string number = "1029381092840293480923";
            var tokenStream = new Tokenizer().Parse(number);
            var token = tokenStream.NextToken();

            Assert.IsNotNull(token);
            Assert.IsTrue(token.Type == TokenType.Integer);
            Assert.IsTrue(token.TokenContent == number);
        }

        [TestMethod]
        public void NextToken_ZerosThenInteger_Found()
        {
            string zeros = "0000";
            string number = "1029381092840293480923";
            string testString = zeros + number;
            var tokenStream = new Tokenizer().Parse(testString);
            Token token;

            for (int i = 0; i < zeros.Length; i++) {
                token = tokenStream.NextToken();

                Assert.IsNotNull(token);
                Assert.IsTrue(token.Type == TokenType.Integer);
                Assert.IsTrue(token.TokenContent == "0");
            }

            token = tokenStream.NextToken();

            Assert.IsNotNull(token);
            Assert.IsTrue(token.Type == TokenType.Integer);
            Assert.IsTrue(token.TokenContent == number);
        }
    }
}
