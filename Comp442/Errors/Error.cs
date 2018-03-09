namespace Errors
{
    public class Error
    {
        public string Message { get; private set; }
        public (int Line, int Column) Location { get; private set; }

        public Error(string message, (int, int) location)
        {
            this.Message = message;
            this.Location = location;
        }

        public Error(string message, int line, int column) : this(message, (line, column))
        {

        }

        public override string ToString()
        {
            return $"{this.Message} - {this.Location}";
        }
    }
}
