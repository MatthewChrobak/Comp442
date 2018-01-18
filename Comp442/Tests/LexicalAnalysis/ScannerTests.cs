using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using LexicalAnalyzer;

namespace Tests.LexicalAnalysis
{
    [TestClass]
    public class ScannerTests
    {
        [TestMethod]
        public void NextChar_ReadFully_ReturnsEachCharacter()
        {
            string testString = "Test";
            var scanner = new Scanner(testString);

            foreach (var character in testString) {
                Assert.AreEqual(scanner.NextChar(), character);
            }
        }

        [TestMethod]
        public void NextChar_PastLength_ExceptionThrown()
        {
            string testString = "Test";
            var scanner = new Scanner(testString);

            foreach (var character in testString) {
                Assert.AreEqual(scanner.NextChar(), character);
            }

            // Test for the failure.
            try {
                scanner.NextChar();
                Assert.Fail();
            } catch {

            }
        }

        [TestMethod]
        public void PrevChar_FromStart_ExceptionThrown()
        {
            var scanner = new Scanner(string.Empty);

            // Test for the failure.
            try {
                scanner.NextChar();
                Assert.Fail();
            } catch {

            }
        }

        [TestMethod]
        public void PrevChar_MidString_ReturnsMidCharacter()
        {
            string testString = "Hello world";
            var scanner = new Scanner(testString);
            var rng = new Random(); // Random test cases.
            int mid = rng.Next(0, testString.Length - 1);

            for (int i = 0; i <= mid; i++) {
                scanner.NextChar();
            }

            // Go back one.
            scanner.PrevChar();

            Assert.AreEqual(scanner.NextChar(), testString[mid]);
        }
    }
}
