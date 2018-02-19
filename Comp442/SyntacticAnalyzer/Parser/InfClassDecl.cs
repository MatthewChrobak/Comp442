﻿using LexicalAnalyzer;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        public bool InfClassDecl()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = AtoCC.Convert(lookaheadToken);

            if ("class".HasToken(lookahead)) {
                if (ClassDecl() && InfClassDecl()) {
                    return true;
                }
            } else {
                if ("program id int float".HasToken(lookahead)) {
                    return true;
                }
            }

            return false;
        }
    }
}