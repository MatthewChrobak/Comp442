using System.Collections.Generic;
using System.Linq;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private List<string> InfIdTrail()
        {
            string first = ",";
            string follow = "{";
            this.SkipErrors(first, follow);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("infIdTrail -> ',' 'id' infIdTrail");

                var lst = new List<string>();

                Match(",");
                string id = Match("id").ToString();
                var trailingIds = InfIdTrail();

                lst.Add(id);
                lst.AddRange(trailingIds.Where(val => val != null));

                return lst;
            }

            if (follow.HasToken(lookahead)) {
                this.ApplyDerivation("infIdTrail -> EPSILON");
                return new List<string>();
            }

            return null;
        }
    }
}
