namespace SemanticalAnalyzer.Pattern
{
    public interface IVisitable
    {
        void Accept(Visitor visitor);
    }
}
