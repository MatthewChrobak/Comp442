﻿using SyntacticAnalyzer.Nodes;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private (ScopeSpec scopeResolution, string functionName) OptSR_AndID()
        {
            string first = "id";
            this.SkipErrors(first);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if (first.HasToken(lookahead)) {
                this.ApplyDerivation("optSR_AndID -> 'id' optSR_AndIDP");
                
                string id = Match("id");
                return OptSR_AndIDP(id, lookaheadToken.SourceLocation);
            }

            return (null, System.String.Empty);
        }
    }
}
