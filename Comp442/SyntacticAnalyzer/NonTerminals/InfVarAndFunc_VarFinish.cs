﻿using SyntacticAnalyzer.Nodes;
using System.Collections.Generic;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private List<object> InfVarAndFunc_VarFinish(string type, string id, (int, int) startLocation)
        {
            string first = "; [ (";
            this.SkipErrors(first);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if ("; [".HasToken(lookahead)) {
                this.ApplyDerivation("infVarAndFunc_VarFinish -> infArraySize ';' infVarAndFunc_VarStart");

                var memberList = new List<object>();
                var variable = new VarDecl(startLocation);
                
                var arraySizes = InfArraySize();
                Match(";");
                var trailingMembers = InfVarAndFunc_VarStart();

                variable.Type = type;
                variable.Id = id;
                variable.Dimensions = arraySizes;

                memberList.Add(variable);
                memberList.JoinListWhereNotNull(trailingMembers);
                return memberList;
            }

            if ("(".HasToken(lookahead)) {
                this.ApplyDerivation("infVarAndFunc_VarFinish -> infVarAndFunc_FuncFinish");

                return InfVarAndFunc_FuncFinish(type, id, startLocation);
            }

            return null;
        }
    }
}
