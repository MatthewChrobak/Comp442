using LexicalAnalyzer.Models;
using ReportGenerator;
using System.Collections.Generic;

namespace LexicalAnalyzer
{
    public partial class Tokenizer : IReportable
    {
        public IEnumerable<Section> GetReportSections(string inputFileName)
        {
            var atoccStreamInput = new Section("Lexical AToCC Input Stream");
            atoccStreamInput.AddRow("<p style='font-weight:lighter;'>This section contains the original token stream converted into AToCC format.</p><hr style='margin-top:0'>");
            atoccStreamInput.AddRow($"<code style='color:black'>{new TokenStream(this.allTokens).FullAToCCFormat}</code>");
            yield return atoccStreamInput;
        }
    }
}
