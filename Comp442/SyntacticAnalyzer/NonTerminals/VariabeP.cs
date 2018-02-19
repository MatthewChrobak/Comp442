﻿using LexicalAnalyzer;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private bool VariableP()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = AtoCC.Convert(lookaheadToken);

            if ("(".HasToken(lookahead)) {
                this.ApplyDerivation("variableP -> '(' aParams ')' '.' 'id' variableP");
                if (Match("(") && AParams() && Match(")") && Match(".") && Match("id") && VariableP()) {
                    return true;
                }
            }

            if ("[ .".HasToken(lookahead)) {
                this.ApplyDerivation("variableP -> infIndice variablePP");
                if (InfIndice() && VariablePP()) {
                    return true;
                }
            }

            if ("= )".HasToken(lookahead)) {
                this.ApplyDerivation("variableP -> infIndice variablePP");
                this.ApplyDerivation("infIndice -> EPSILON");
                this.ApplyDerivation("variablePP -> EPSILON");
                return true;
            }

            return false;
        }
    }
}