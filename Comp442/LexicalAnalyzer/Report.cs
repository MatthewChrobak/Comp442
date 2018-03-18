using ReportGenerator;
using System.Collections.Generic;

namespace LexicalAnalyzer
{
    public partial class Tokenizer : IReportable
    {
        public IEnumerable<Section> GetReportSections(string inputFileName)
        {
            return new List<Section>();
        }
    }
}
