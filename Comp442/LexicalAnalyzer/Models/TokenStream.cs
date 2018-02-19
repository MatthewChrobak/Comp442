using System.Collections.Generic;

namespace LexicalAnalyzer.Models
{
    public class TokenStream
    {
        private Queue<Token> _queue;

        public string FullAToCCFormat { private set; get; }

        public TokenStream(Queue<Token> queue)
        {
            this._queue = queue;
            this.FullAToCCFormat = queue.ToArray().AToCC();
        }

        public Token NextToken()
        {
            return this._queue.Dequeue();
        }

        public Token Peek()
        {
            return this._queue.Peek();
        }
    }
}
