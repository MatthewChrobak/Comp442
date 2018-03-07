namespace SyntacticAnalyzer.Pattern
{
    public interface IVisitable
    {
        void Accept(Visitor visitor);
    }
}
