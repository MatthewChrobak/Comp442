﻿using System;
using LexicalAnalyzer;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool FuncBody()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = AtoCC.Convert(lookaheadToken);

            if ("{".HasToken(lookahead)) {
                if (Match("{") && InfVarAndState() && Match("}")) {
                    return true;
                }
            }

            return false;
        }
    }
}