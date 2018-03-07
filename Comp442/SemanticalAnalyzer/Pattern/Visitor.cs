namespace SemanticalAnalyzer.Pattern
{
    public abstract class Visitor : IVisitable
    {
        public virtual void Accept(Visitor visitor)
        {

        }
    }
}
