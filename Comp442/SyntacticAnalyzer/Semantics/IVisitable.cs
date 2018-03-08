namespace SyntacticAnalyzer.Semantics
{
    public interface IVisitable
    {
        void Accept(Visitor visitor);
    }
}
