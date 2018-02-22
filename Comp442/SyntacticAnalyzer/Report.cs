using ReportGenerator;
using SyntacticAnalyzer.Nodes;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Xml.Serialization;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser : IReportable
    {
        public IEnumerable<Section> GetReportSections(string inputFileName)
        {
            foreach (var section in this._tokenizer.GetReportSections(inputFileName)) {
                yield return section;
            }

            bool validProgram = this.Verify();
            var validProgramSection = new Section("Valid Program");
            validProgramSection.AddRow(validProgram ? "Yes" : "No");
            yield return validProgramSection;

            var atoccStreamInput = new Section("AToCC Input Stream");
            atoccStreamInput.AddRow($"<code style='color:black'>{this.TokenStream.FullAToCCFormat}</code>");
            yield return atoccStreamInput;


            var atoccStreamOutput = new Section("Last Derivation in AToCC Format");
            atoccStreamOutput.AddRow($"<code style='color:black'>{this.Derivations.Last().SententialForm.Replace(' ', '\0').Replace('\'', '\0')}</code>");
            yield return atoccStreamOutput;

            

            var errorList = new Section("Syntactic Error List");
            foreach (var error in this.Errors) {
                errorList.AddRow(error);
            }
            if (!validProgram) {
                yield return errorList;
            }



            using (var fs = new FileStream(inputFileName + ".xml", FileMode.Create)) {
                var serializer = new XmlSerializer(typeof(Program));
                serializer.Serialize(fs, this.AST);
            }

            var astSection = new Section("Abstract Syntax Tree");
            astSection.AddRow($"<div id='AST' class='AST' style='background-color:rgb(150, 150, 150);'><script>xml2tree('AST', '{inputFileName + ".xml"}', [], false, false);</script></div>");

            if (validProgram) {
                yield return astSection;
            }




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

            if (validProgram) {
                yield return derivSection;
            }




            
        }
    }
}
