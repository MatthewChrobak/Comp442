using SyntacticAnalyzer.Nodes;
using System.Linq;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private InherList OptInheritance()
        {
            string first = ":";
            string follow = "{";
            this.SkipErrors(first, follow);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("optInheritance -> ':' 'id' infIdTrail");

                var astNode = new InherList(lookaheadToken.SourceLocation);
                
                Match(":");
                string id = Match("id").ToString();
                var trailingInheritance = InfIdTrail();

                astNode.IDs.Add(id);
                astNode.IDs.AddRange(trailingInheritance?.Where(obj => obj != null));

                return astNode;
            }

            if (follow.HasToken(lookahead)) {
                this.ApplyDerivation("optInheritance -> EPSILON");
                return new InherList(lookaheadToken.SourceLocation);
            }

            return null;
        }
    }
}
