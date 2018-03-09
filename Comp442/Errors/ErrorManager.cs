using ReportGenerator;
using System.Collections.Generic;
using System.Linq;

namespace Errors
{
    public static class ErrorManager
    {
        private static List<Error> ErrorList;

        static ErrorManager()
        {
            ErrorList = new List<Error>();
        }

        public static List<Error> GetFullList()
        {
            return ErrorList.OrderBy(entry => entry.Location).ToList();
        }

        public static void Add(Error error)
        {
            ErrorList.Add(error);
        }

        public static void Add(string message, (int, int) location)
        {
            Add(new Error(message, location));
        }

        public static void Reset()
        {
            ErrorList.Clear();
        }

        public static int Count()
        {
            return ErrorList.Count;
        }

        public static IEnumerable<Section> GetReportSection()
        {
            var section = new Section("Error List");
            section.AddRow("<p style='font-weight:lighter;'>Contains all the errors found in the compilation process.</p><hr style='margin-top:0'>");

            if (Count() == 0) {
                section.AddRow("No errors");
            } else {
                foreach (var error in GetFullList()) {
                    section.Add($"<div class='col-sm-8'>{error.Message}</div>");
                    section.Add($"<div class='col-sm-4'>{error.Location}</div>");
                }
            }
            yield return section;
        }
    }
}
