using ReportGenerator;
using SyntacticAnalyzer.Parser;
using System;
using System.Diagnostics;
using System.IO;

namespace Assignment2
{
    public class Program
    {
        public static void Main(string[] args)
        {
            while (true) {
                Console.Write("Please enter a filename for input: ");
                string file = Console.ReadLine();

                if (!File.Exists(file)) {
                    Console.WriteLine("File does not exist.");
                    continue;
                }
                var parser = new Parser(File.ReadAllLines(file));

                parser.Parse();

                var report = new Report();
                Console.Write("Generating report... ");
                report.Sections.AddRange(parser.GetReportSections(file));
                File.WriteAllText(file + ".html", report.GenerateReport());
                Console.WriteLine("Done.");

                Process.Start(file + ".html");
            }
        }
    }
}
