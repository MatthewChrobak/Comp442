using System.Text;

namespace ReportGenerator
{
    public class Section
    {
        public string Header { get; set; }
        public StringBuilder Content { get; set; } = new StringBuilder();
        private bool _collapsable;

        public Section(string header, bool collapsable = false)
        {
            this.Header = header;
            this._collapsable = collapsable;
        }

        public void Add(string content)
        {
            this.Content.Append(content);
        }

        public void AddRowStart()
        {
            this.Add("<div class='col-sm-12'>");
        }

        public void AddRowEnd()
        {
            this.Add("</div>");
        }

        public void AddRow(string content)
        {
            this.AddRowStart();
            this.Add(content);
            this.AddRowEnd();
        }

        public string Generate()
        {
            string id = this.Header.Replace(' ', '_');
            string collapseId = this.Header + "_collapse";

            string code = System.String.Empty;

            if (_collapsable) {
                code += $"<div class='container' id='{id}' style='margin-top:100px;'><div class='row'><div class='col-sm-8'><h2>{this.Header}</h2></div>";
                code += $"<div class='col-sm-4'>" +
                    $"<button class='btn btn-info btn-block' type='button' data-toggle='collapse' data-target='#{collapseId}' aria-expanded='false' aria-controls='collapseExample'>Toggle Visibility</button>" +
                    $"</div>";
            } else {
                code += $"<div class='container' id='{id}' style='margin-top:100px;'><div class='row'><div class='col-sm-12'><h2>{this.Header}</h2></div>"; 
            }

            code += $"</div></div>";

            return code + $"<div class='container " +
                (_collapsable ? "collapse" : string.Empty) +
                $"' id='{collapseId}'><div class='row'>{this.Content.ToString()}</div></div>";
        }
    }
}
