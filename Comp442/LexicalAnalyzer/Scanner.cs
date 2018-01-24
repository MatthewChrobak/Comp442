namespace LexicalAnalyzer
{
    public class Scanner
    {
        private string _characters { get; set; }
        private int _ptr { get; set; }
        private int? _length { get; set; }

        public int PointerPostion => this._ptr;

        public Scanner(string characterStream)
        {
            // Add whitespace to the end.
            this._characters = characterStream + " ";
            this._length = characterStream.Length;
            this._ptr = 0;
        }

        public bool HasNextChar()
        {
            return this._ptr < this._length;
        }

        public char NextChar()
        {
            if (this._ptr >= this._characters.Length) {
                throw new System.Exception("Out of bounds.");
            }

            return this._characters[this._ptr++];
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
            if (this._ptr <= 0) {
                throw new System.Exception("Out of bounds.");
            }

            this._ptr--;
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
