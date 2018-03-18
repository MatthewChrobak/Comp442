using Errors;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using ReportGenerator;
using SemanticalAnalyzer;
using SyntacticAnalyzer.Parser;
using System.IO;

namespace Tests.SemanticAnalysis
{
    [TestClass]
    public class VisitorTests
    {
        [TestMethod]
        public void Coverage()
        {
            foreach (string file in Directory.GetFiles("testcases/", "*.txt")) {
                var parser = new Parser(File.ReadAllLines(file));
                parser.Parse();

                var semantics = new LanguageSemantics();
                semantics.Apply(parser.AbstractSyntaxTree);

                var report = new Report();
                report.Sections.AddRange(parser.GetReportSections(file));
                report.Sections.AddRange(semantics.GetReportSections(file));
                File.WriteAllText(file + ".html", report.GenerateReport());

                if (file.Contains("invalid")) {
                    Assert.IsTrue(ErrorManager.Count() != 0, file);
                } else {
                    Assert.IsTrue(ErrorManager.Count() == 0, file);
                }
            }

            foreach (string file in Directory.GetFiles("tests/", "*.txt")) {
                var parser = new Parser(File.ReadAllLines(file));
                parser.Parse();

                var semantics = new LanguageSemantics();
                semantics.Apply(parser.AbstractSyntaxTree);

                var report = new Report();
                report.Sections.AddRange(parser.GetReportSections(file));
                report.Sections.AddRange(semantics.GetReportSections(file));
                File.WriteAllText(file + ".html", report.GenerateReport());
            }
        }
    }
}
