using ReportGenerator;
using SyntacticAnalyzer.Nodes;
using SyntacticAnalyzer.Semantics;
using System.Collections.Generic;

namespace SemanticalAnalyzer
{
    public partial class LanguageSemantics : IReportable
    {
        public IEnumerable<Section> GetReportSections(string inputFileName)
        {
            var section = new Section("Symbol Table");

            var funcList = new List<FuncDef>();
            var classList = new List<ClassDecl>();

            this.AST.Classes?.Classes.ForEach(clss => {
                classList.Add(clss);
            });

            this.AST.Functions?.Functions.ForEach(func => {
                funcList.Add(func);
            });


            var globalScope = this.AST.Table;


            section.AddRowStart();
            section.Add("<table class='table table-dark'>");
            section.Add("<tr><th>Symbol Table: Global</th></tr>");
            section.Add("<tr><th>Name</th><th>Kind</th><th>Type</th></tr>");
            foreach (var entry in globalScope.GetAll()) {
                section.Add($"<tr><td>{entry.ID}</td><td>{entry.EntryType}</td><td></td></tr>");
            }
            section.Add("</table>");
            section.AddRowEnd();

            foreach (var entry in globalScope.GetAll(TableEntryType.Class)) {
                section.AddRowStart();
                section.Add("<table class='table table-dark'>");
                section.Add($"<tr><th>Symbol Table: Class {entry.ID}</th></tr>");
                section.Add("<tr><th>Name</th><th>Kind</th><th>Type</th></tr>");
                var link = entry.Link;
                foreach (var classEntry in link.GetAll()) {
                    section.Add($"<tr><td>{classEntry.ID}</td><td>{classEntry.EntryType}</td><td></td></tr>");
                }
                section.Add("</table>");
                section.AddRowEnd();
            }

            
            foreach (var func in funcList) {
                //section.AddRow($"{func.Table}");
            }

            yield return section;
        }
    }
}
