using SyntacticAnalyzer.Nodes;
using System.Linq;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private ClassListNode InfClassDecl()
        {
            string first = "class";
            string follow = "program id int float";
            this.SkipErrors(first, follow);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("infClassDecl -> classDecl infClassDecl");

                // This will recursively get all the classes into ONE classlist.
                // 1) Create a new classlist node to store our classes in.
                var astNode = new ClassListNode();

                // 2) Parse the current class, and retrieve the trailing classes.
                var declaredClass = ClassDecl();
                var trailingClasses = InfClassDecl();

                // 3) Add them all to the classlist if they exist.
                astNode.ClassList.Add(new ClassDecl());
                astNode.ClassList.AddRange(trailingClasses?.ClassList.Where(obj => obj != null));

                return astNode;
            }

            if (follow.HasToken(lookahead)) {
                this.ApplyDerivation("infClassDecl -> EPSILON");
                
                // Return an empty classlist to signify that it WAS parsed correctly.
                return new ClassListNode();
            }

            return null;
        }
    }
}
