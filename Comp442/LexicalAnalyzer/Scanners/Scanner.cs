using System.Linq;

namespace LexicalAnalyzer.Scanners
{
    public class Scanner
    {
        private string[] _lines { get; set; }
        private int _linePtr { get; set; }
        private int _characterPtr { get; set; }

        public (int lineNumber, int characterNumber) CursorPosition => (this._linePtr, this._characterPtr);

        public Scanner(string line) : this(new string[] { line })
        {

        }

        public Scanner(string[] lines)
        {
            for (int i = 0; i < lines.Length; i++) {
                lines[i] = lines[i].Replace("\t", "    ");
            }

            if (lines.Length != 0) {
                lines = lines.Select(line => line + "\n").ToArray();
                lines[lines.Length - 1] += " ";
            }

            this._lines = lines;
            this._linePtr = 0;
            this._characterPtr = 0;
        }

        private string GetCurrentLine()
        {
            return this._lines[this._linePtr];
        }

        public bool HasNextChar()
        {
            // _characterPtr only is important on the last line.
            if (this._linePtr < this._lines.Length - 1) {
                return true;
            }

            if (this._linePtr < this._lines.Length) {
                return this._characterPtr < this.GetCurrentLine().Length;
            }

            return false;
        }

        public char NextChar()
        {
            if (!this.HasNextChar()) {
                throw new System.Exception("Out of bounds");
            }

            // If we're out of bounds on the current line, increment the line number.
            while (this._characterPtr >= this.GetCurrentLine().Length) {
                this._linePtr++;
                this._characterPtr = 0;
            }

            return this.GetCurrentLine()[this._characterPtr++];
        }

        public char NextCharNoEx(char exceptionCharacter = ' ')
        {
            try {
                return this.NextChar();
            } catch (System.Exception) {
                return exceptionCharacter;
            }
        }

        public void PrevChar()
        {
            if (this._characterPtr > 0) {
                this._characterPtr--;
            } else {
                if (this._linePtr > 0) {
                    this._linePtr--;
                    this._characterPtr = 0;
                } else {
                    throw new System.Exception("Out of bounds");
                }
            }
        }

        public void GoBack(int count = 1)
        {
            if (count < 0) {
                throw new System.Exception("Negative GoBack count.");
            }
            for (uint i = 0; i < count; i++) {
                this.PrevChar();
            }
        }
    }
}
