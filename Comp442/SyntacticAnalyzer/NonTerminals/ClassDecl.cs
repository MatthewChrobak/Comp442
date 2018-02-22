using SyntacticAnalyzer.Nodes;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private ClassDecl ClassDecl()
        {
            string first = "class";
            this.SkipErrors(first);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("classDecl -> 'class' 'id' optInheritance '{' infVarAndFunc_VarStart '}' ';'");

                var @class = new ClassDecl();

                Match("class");
                Match("id");
                var inheritance = OptInheritance();
                Match("{");
                var variablesAndFunctions = InfVarAndFunc_VarStart();
                Match("}");
                Match(";");

                @class.InheritingClasses = inheritance;
                @class.Members = variablesAndFunctions;

                return @class;
            }
            
            return null;
        }
    }
}
