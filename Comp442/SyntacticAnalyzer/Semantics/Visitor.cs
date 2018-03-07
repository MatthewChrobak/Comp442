using System;
using SyntacticAnalyzer.Nodes;

namespace SyntacticAnalyzer.Pattern
{
    public abstract class Visitor
    {
        public virtual void Visit(Program node)
        {
            throw new NotImplementedException();
        }

        public virtual void Visit(PutStat putStat)
        {
            throw new NotImplementedException();
        }

        public virtual void Visit(DataMember dataMember)
        {
            throw new NotImplementedException();
        }

        public virtual void Visit(ClassList classList)
        {
            throw new NotImplementedException();
        }

        public virtual void Visit(ClassDecl classDecl)
        {
            throw new NotImplementedException();
        }

        public virtual void Visit(FCall fCall)
        {
            throw new NotImplementedException();
        }

        public virtual void Visit(GetStat getStat)
        {
            throw new NotImplementedException();
        }

        public virtual void Visit(FParam fParam)
        {
            throw new NotImplementedException();
        }

        public virtual void Visit(AParams aParams)
        {
            throw new NotImplementedException();
        }

        public virtual void Visit(AssignStat assignStat)
        {
            throw new NotImplementedException();
        }

        public virtual void Visit(FuncDefList funcDefList)
        {
            throw new NotImplementedException();
        }

        public virtual void Visit(FuncDecl funcDecl)
        {
            throw new NotImplementedException();
        }

        public virtual void Visit(InherList inherList)
        {
            throw new NotImplementedException();
        }

        public virtual void Visit(AddOp addOp)
        {
            throw new NotImplementedException();
        }

        public virtual void Visit(FuncDef funcDef)
        {
            throw new NotImplementedException();
        }

        public virtual void Visit(ScopeSpec scopeSpec)
        {
            throw new NotImplementedException();
        }

        public virtual void Visit(ForStat forStat)
        {
            throw new NotImplementedException();
        }

        public virtual void Visit(Var var)
        {
            throw new NotImplementedException();
        }

        public virtual void Visit(StatBlock statBlock)
        {
            throw new NotImplementedException();
        }

        public virtual void Visit(Sign sign)
        {
            throw new NotImplementedException();
        }

        public virtual void Visit(ReturnStat returnStat)
        {
            throw new NotImplementedException();
        }

        public virtual void Visit(IfStat ifStat)
        {
            throw new NotImplementedException();
        }

        public virtual void Visit(IndexList indexList)
        {
            throw new NotImplementedException();
        }

        public virtual void Visit(Not not)
        {
            throw new NotImplementedException();
        }

        public virtual void Visit(RelExpr relExpr)
        {
            throw new NotImplementedException();
        }

        public virtual void Visit(MultOp multOp)
        {
            throw new NotImplementedException();
        }
    }
}
