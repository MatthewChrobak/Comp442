using ReportGenerator;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser : IReportable
    {
        public IEnumerable<Section> GetReportSections()
        {
            foreach (var section in this._tokenizer.GetReportSections()) {
                yield return section;
            }

            var validProg = new Section("Valid Program");
            validProg.AddRow(this.Verify() ? "Yes" : "No");
            yield return validProg;

            var atoccStreamInput = new Section("AToCC Input Stream");
            atoccStreamInput.AddRow($"<code style='color:black'>{this.TokenStream.FullAToCCFormat}</code>");
            yield return atoccStreamInput;


            var atoccStreamOutput = new Section("Last Derivation in AToCC Format");
            atoccStreamOutput.AddRow($"<code style='color:black'>{this.Derivations.Last().SententialForm.Replace(' ', '\0').Replace('\'', '\0')}</code>");
            yield return atoccStreamOutput;

            var errorList = new Section("Syntactic Error List");
            if (this.Errors.Count == 0) {
                errorList.AddRow("No errors");
            } else {
                foreach (var error in this.Errors) {
                    errorList.AddRow(error);
                }
            }
            yield return errorList;
            
            

            var derivSection = new Section("Derivations", true);
            derivSection.AddRowStart();
            derivSection.Add("<table class='table table-hover' style='color:red'><tr style='color:black'><th>Rule Applied</th><th>Sentential Form</th></tr>");

            string terminalRule(string str) => Regex.Replace(str, "\'(\\S+)\'", "<span style=' color:black'>'$1'</span>");
            string epsilonRule(string str) => Regex.Replace(str, "EPSILON", "<span style=' color:blue'>EPSILON</span>");

            foreach (var derivation in this.Derivations) {

                string rule = terminalRule(epsilonRule(derivation.Rule.Replace("->", "<span style=' color:black'>-></span>")));
                string sententialForm = terminalRule(epsilonRule(derivation.SententialForm));

                //string rule = derivation.Rule;
                //string sententialForm = derivation.SententialForm;

                derivSection.Add($"<tr><td>{rule}</td><td>{sententialForm}</td></tr>");
            }
            derivSection.Add("</table>");
            derivSection.AddRowEnd();

            yield return derivSection;

        }
    }
}
