using LexicalAnalyzer;

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

        public bool ClassDecl()
        {
            if (Match("class") && Match("id") && OptInheritance() && Match("{") && InfVarAndFunc_VarStart() && Match("}") && Match(";")) {
                return true;
            }

            return false;
        }

        public bool OptInheritance()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = AtoCC.Convert(lookaheadToken);

            if (":".HasToken(lookahead)) {
                if (Match(":") && Match("id") && InfIdTrail()) {
                    return true;
                }
            } else {
                if ("{".HasToken(lookahead)) {
                    return true;
                }
            }

            return false;
        }

        public bool InfIdTrail()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = AtoCC.Convert(lookaheadToken);

            if (",".HasToken(lookahead)) {
                if (Match(",") && Match("id") && InfIdTrail()) {
                    return true;
                }
            } else {
                if ("{".HasToken(lookahead)) {
                    return true;
                }
            }

            return false;
        }

        public bool InfVarAndFunc_VarStart()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = AtoCC.Convert(lookaheadToken);

            if ("id int float".HasToken(lookahead)) {
                if (Type() && Match("id") && InfVarAndFunc_VarFinish()) {
                    return true;
                }
            } else {
                if ("}".HasToken(lookahead)) {
                    return true;
                }
            }

            return false;
        }

        public bool InfVarAndFunc_VarFinish()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = AtoCC.Convert(lookaheadToken);

            if ("; [".HasToken(lookahead)) {
                if (InfArraySize() && Match(";") && InfVarAndFunc_VarStart()) {
                    return true;
                }
            } else if ("(".HasToken(lookahead)) {
                if (InfVarAndFunc_FuncFinish()) {
                    return true;
                }
            } else {
                if ("}".HasToken(lookahead)) {
                    return true;
                }
            }

            return false;
        }

        public bool InfVarAndFunc_FuncStart()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = AtoCC.Convert(lookaheadToken);

            if ("id int float".HasToken(lookahead)) {
                if (Type() && Match("id") && InfVarAndFunc_FuncFinish()) {
                    return true;
                }
            } else {
                if ("}".HasToken(lookahead)) {
                    return true;
                }
            }

            return false;
        }

        public bool InfVarAndFunc_FuncFinish()
        {
            var lookaheadToken = this._tokenStream.Peek();
            string lookahead = AtoCC.Convert(lookaheadToken);

            if ("(".HasToken(lookahead)) {
                if (Match("(") && FParams() && Match(")") && Match(";") && InfVarAndFunc_FuncStart()) {
                    return true;
                }
            } else {
                if ("}".HasToken(lookahead)) {
                    return true;
                }
            }

            return false;
        }
    }
}
