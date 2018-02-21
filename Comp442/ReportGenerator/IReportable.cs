using System.Collections.Generic;

namespace ReportGenerator
{
    public interface IReportable
    {
        IEnumerable<Section> GetReportSections(string inputFileName);
    }
}
