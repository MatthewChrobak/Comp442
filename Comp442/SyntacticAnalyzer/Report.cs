using Errors;
using ReportGenerator;
using SyntacticAnalyzer.Nodes;
using System;
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
            bool validProgram = this.Verify();
            var validProgramSection = new Section("Valid Program");
            validProgramSection.AddRow("<p style='font-weight:lighter;'>This section displays whether or not the given program is lexically and syntactically correct.</p><hr style='margin-top:0'>");
            validProgramSection.AddRow(validProgram ? "Program is valid." : "Program is invalid: " + ErrorManager.Count() + " errors were found.");
            yield return validProgramSection;

            foreach (var section in ErrorManager.GetReportSection()) {
                yield return section;
            }

            foreach (var section in WarningManager.GetReportSection()) {
                yield return section;
            }

            foreach (var section in this._tokenizer.GetReportSections(inputFileName)) {
                yield return section;
            }

            var atoccStreamInput = new Section("Pruned Lexical AToCC Input Stream");
            atoccStreamInput.AddRow("<p style='font-weight:lighter;'>This section contains the original token stream converted into AToCC format with comments removed.</p><hr style='margin-top:0'>");
            atoccStreamInput.AddRow($"<code style='color:black'>{this.TokenStream.FullAToCCFormat}</code>");
            yield return atoccStreamInput;


            var atoccStreamOutput = new Section("Last Derivation in AToCC Format");
            atoccStreamOutput.AddRow("<p style='font-weight:lighter;'>This section contains the last derivation done in the syntactic analysis converted into AToCC format.</p><hr style='margin-top:0'>");
            atoccStreamOutput.AddRow($"<code style='color:black'>{this.Derivations.Last().SententialForm.Replace(' ', '\0').Replace('\'', '\0')}</code>");
            if (validProgram) {
                yield return atoccStreamOutput;
            }
            

            var absStream = new Section("Abstract Syntax Tree Traversal", true);
            absStream.AddRow("<p style='font-weight:lighter;'>Displays the reconstruction of the original program through the traversal of the Abstract Syntax Tree data structure." +
                " Note that minor non-errors may occur in the reconstruction such as: missing or additional semi-colons, and missing or additional whitespace.</p><hr style='margin-top:0'>");
            absStream.AddRow($"<code style='color:black'>{this.AbstractSyntaxTree?.ToString().Replace(">", "&gt;").Replace("<", "&lt;").Replace("\n", "<br>").Replace("\t", "&nbsp;&nbsp;")}</code>");
            if (validProgram) {
                yield return absStream;
            }


            using (var fs = new FileStream(inputFileName + ".xml", FileMode.Create)) {
                var serializer = new XmlSerializer(typeof(Program), new System.Type[] {
                    typeof(AddOp),
                    typeof(Nodes.AParams),
                    typeof(AssignStat),
                    typeof(ClassDecl),
                    typeof(ClassList),
                    typeof(DataMember),
                    typeof(FCall),
                    typeof(ForStat),
                    typeof(FParam),
                    typeof(FuncDecl),
                    typeof(FuncDef),
                    typeof(FuncDefList),
                    typeof(GetStat),
                    typeof(IfStat),
                    typeof(IndexList),
                    typeof(InherList),
                    typeof(MultOp),
                    typeof(Not),
                    typeof(PutStat),
                    typeof(RelExpr),
                    typeof(ReturnStat),
                    typeof(ScopeSpec),
                    typeof(Sign),
                    typeof(StatBlock),
                    typeof(MainStatBlock),
                    typeof(Var),
                    typeof(VarDecl),
                    typeof(Integer),
                    typeof(Float)
                });
                serializer.Serialize(fs, this.AbstractSyntaxTree);
                
            }

        var astSection = new Section("Abstract Syntax Tree");
            astSection.AddRow("<p style='font-weight:lighter;'>Displays the Abstract Syntax Tree data structure in a tree format. You can click on nodes to expand or collapse their children.</p><hr style='margin-top:0'>");
            astSection.AddRow("<button class='btn btn-danger' onclick=\"" +
                @"
var clickEvent = new MouseEvent('click', {
'view': window,
'bubbles': true,
'cancelable': false
});
var elements = document.getElementsByTagName('circle');
for (var i = 0; i < elements.length; i++) {
    var element = elements[i];
    if (element.style.fill != 'rgb(255, 255, 255)') {
        elements[i].dispatchEvent(clickEvent);
    }
}
" +
                "\">Expand - MAY TAKE A LONG TIME</button>");
            astSection.AddRow($"<div id='AST' class='AST' style='background-color:rgb(150, 150, 150);'><script>xml2tree('AST', '{inputFileName + ".xml"}', [], false, false);</script></div>");

            if (validProgram) {
                yield return astSection;
            }




            var derivSection = new Section("Derivations", true);
            derivSection.AddRow("<p style='font-weight:lighter;'>Contains the full derivation of the program that was parsed, and details each rule that was applied and the resulting sentential form as a result of its application.</p><hr style='margin-top:0'>");
            derivSection.AddRowStart();
            derivSection.Add("<table class='table table-hover' style='color:red'><tr style='color:black'><th>Rule Applied</th><th>Sentential Form</th></tr>");

            string terminalRule(string str) => Regex.Replace(str, "\'(\\S+)\'", "<span style=' color:black'>'$1'</span>");
            string epsilonRule(string str) => Regex.Replace(str, "EPSILON", "<span style=' color:blue'>EPSILON</span>");

            foreach (var derivation in this.Derivations) {

                string rule = terminalRule(epsilonRule(derivation.Rule.Replace("->", "<span style=' color:black'>-></span>")));
                string sententialForm = terminalRule(epsilonRule(derivation.SententialForm));

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
