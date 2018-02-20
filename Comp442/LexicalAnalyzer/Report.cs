using ReportGenerator;
using System.Collections.Generic;

namespace LexicalAnalyzer
{
    public partial class Tokenizer : IReportable
    {
        public IEnumerable<Section> GetReportSections()
        {
            var section = new Section("Lexical Errors", true);

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
