using ReportGenerator;
using System.Collections.Generic;

namespace LexicalAnalyzer
{
    public partial class Tokenizer : IReportable
    {
        public IEnumerable<Section> GetReportSections(string inputFileName)
        {
            var section = new Section("Lexical Errors", true);
            section.AddRow("<p style='font-weight:lighter;'>Contains all the lexical errors found in the parsing process. Note that lexial errors do not imply that a program is wrong, and merely expresses that the parser did not continue adding content to a token due to an unexpected symbol.</p><hr style='margin-top:0'>");

            if (this.Errors.Count == 0) {
                section.AddRow("No errors");
            } else {
                foreach (string error in this.Errors) {
                    section.AddRow(error);
                }
            }

            yield return section;
        }
    }
}
