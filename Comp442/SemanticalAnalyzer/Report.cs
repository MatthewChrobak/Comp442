using ReportGenerator;
using SyntacticAnalyzer.Semantics;
using System.Collections.Generic;

namespace SemanticalAnalyzer
{
    public partial class LanguageSemantics : IReportable
    {
        public IEnumerable<Section> GetReportSections(string inputFileName)
        {
            var section = new Section("Symbol Table");
            section.AddRow("Variable declaration in for-loops is handled in a more dynamic way at traversal time and will not appear in these symbol tables. <hr>");


            var globalScope = this.AST.Table;


            section.AddRowStart();
            section.Add("<table class='table table-dark'>");
            section.Add("<tr><th>Symbol Table: Global</th></tr>");
            section.Add("<tr><th>Name</th><th>Kind</th><th>Type</th></tr>");
            foreach (var entry in globalScope.GetAll()) {
                section.Add($"<tr><td>{entry.ID}</td><td>{entry.Classification}</td><td>{entry.Type}</td></tr>");
            }
            section.Add("</table>");
            section.AddRowEnd();

            foreach (var entry in globalScope?.GetAll(Classification.Class)) {
                section.AddRowStart();
                section.Add("<table class='table table-dark'>");
                section.Add($"<tr><th>Symbol Table: Class {entry.ID}</th></tr>");
                section.Add("<tr><th>Name</th><th>Kind</th><th>Type</th><th>Linked</th></tr>");
                foreach (var classEntry in entry.Link.GetAll()) {
                    section.Add($"<tr><td>{classEntry.ID}</td><td>{classEntry.Classification}</td><td>{classEntry.Type}</td><td>{classEntry.Link != null}</td></tr>");
                }
                section.Add("</table>");
                section.AddRowEnd();
            }


            foreach (var entry in globalScope?.GetAll(Classification.Function)) {
                section.AddRowStart();
                section.Add("<table class='table table-dark'>");
                section.Add($"<tr><th>Symbol Table: Function {entry.ID}</th></tr>");
                section.Add("<tr><th>Name</th><th>Kind</th><th>Type</th></tr>");
                
                foreach (var variable in entry.Link.GetAll()) {
                    section.Add($"<tr><td>{variable.ID}</td><td>{variable.Classification}</td><td>{variable.Type}</td></tr>");
                }
                section.Add("</table>");
                section.AddRowEnd();
            }

            yield return section;
        }
    }
}
