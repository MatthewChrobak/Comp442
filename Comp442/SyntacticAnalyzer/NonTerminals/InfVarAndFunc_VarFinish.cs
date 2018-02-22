using SyntacticAnalyzer.Nodes;

namespace SyntacticAnalyzer.Parser
{
    public partial class Parser
    {
        private MembList InfVarAndFunc_VarFinish(string type, string id)
        {
            string first = "; [ (";
            this.SkipErrors(first);

            var lookaheadToken = this.TokenStream.Peek();
            string lookahead = lookaheadToken.AToCCFormat();

            if ("; [".HasToken(lookahead)) {
                this.ApplyDerivation("infVarAndFunc_VarFinish -> infArraySize ';' infVarAndFunc_VarStart");

                var memberList = new MembList();
                var variable = new VarDecl();
                
                var arraySizes = InfArraySize();
                Match(";");
                var trailingVarAndFuncList = InfVarAndFunc_VarStart();

                variable.Type = type;
                variable.Id = id;
                variable.Dimentions = arraySizes;

                memberList.Members.Add(variable);
                memberList.Members.AddRange(trailingVarAndFuncList?.Members);
                return memberList;
            }

            if ("(".HasToken(lookahead)) {
                this.ApplyDerivation("infVarAndFunc_VarFinish -> infVarAndFunc_FuncFinish");

                return InfVarAndFunc_FuncFinish();
            }

            return null;
        }
    }
}
