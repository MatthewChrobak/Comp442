using Microsoft.VisualStudio.TestTools.UnitTesting;
using ReportGenerator;
using SyntacticAnalyzer.Parser;
using System.Diagnostics;
using System.IO;

namespace Tests.SyntacticAnalysis
{
    [TestClass]
    public class ParserTests
    {
        [TestMethod]
        public void Coverage()
        {
            string file = $"input.txt";

            var parser = new Parser(File.ReadAllLines(file));

            var report = new Report();

            parser.Parse();
            report.Sections.AddRange(parser.GetReportSections(file));
            File.WriteAllText(file + ".html", report.GenerateReport());

            Process.Start(file + ".html");
        }
    }
}
