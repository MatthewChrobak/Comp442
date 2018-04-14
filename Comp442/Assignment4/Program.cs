using CodeGeneration;
using Errors;
using ReportGenerator;
using SemanticalAnalyzer;
using SyntacticAnalyzer.Parser;
using System;
using System.Diagnostics;
using System.IO;

namespace Assignment4
{
    public class Program
    {
        private static void Main(string[] args)
        {
            while (true) {
                Console.Write("Please enter a filename for input: ");
                string file = Console.ReadLine();

                if (!File.Exists(file)) {
                    Console.WriteLine("File does not exist.");
                    continue;
                }

                var report = new Report();

                // Parse the program.
                var parser = new Parser(File.ReadAllLines(file));
                parser.Parse();

                // Apply the semantics.
                var semantics = new LanguageSemantics();
                semantics.Apply(parser.AbstractSyntaxTree);
                

                // Generate the code.
                var codeGen = new CodeGenerator();
                if (ErrorManager.Count() == 0) {
                    codeGen.Generate(parser.AbstractSyntaxTree);
                }

                report.Sections.AddRange(parser.GetReportSections(file));
                report.Sections.AddRange(semantics.GetReportSections(file));
                report.Sections.AddRange(codeGen.GetReportSections(file));


                File.WriteAllText(file + ".html", report.GenerateReport());
                Console.WriteLine("Done.");

                File.WriteAllLines(file + ".m", InstructionStream.Instructions.ToArray());

                Process.Start(System.AppDomain.CurrentDomain.BaseDirectory + "/" + file + ".html");
            }
        }
    }
}
