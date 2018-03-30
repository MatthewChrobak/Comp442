using System;
using SyntacticAnalyzer.Nodes;

namespace SyntacticAnalyzer.Semantics
{
    public abstract class Visitor
    {
        public virtual void Visit(Program node)
        {
            
        }

        public virtual void Visit(PutStat putStat)
        {
            
        }

        public virtual void Visit(Float @float)
        {

        }

        public virtual void Visit(Integer integer)
        {

        }

        public virtual void Visit(DataMember dataMember)
        {
            
        }

        public virtual void Visit(VarDecl varDecl)
        {
            
        }

        public virtual void PreVisit(MainStatBlock mainStatBlock)
        {
            
        }

        public virtual void PreVisit(Var var)
        {

        }

        public virtual void PreVisit(ClassList classList)
        {

        }

        public virtual void Visit(ClassList classList)
        {
            
        }

        public virtual void PreVisit(ClassDecl classDecl)
        {

        }

        public virtual void Visit(ClassDecl classDecl)
        {
            
        }

        public virtual void Visit(FCall fCall)
        {
            
        }

        public virtual void Visit(GetStat getStat)
        {
            
        }

        public virtual void PreVisit(FuncDef funcDef)
        {
            
        }

        public virtual void Visit(FParam fParam)
        {
            
        }

        public virtual void Visit(AParams aParams)
        {
            
        }

        public virtual void PreVisit(ForStat forStat)
        {

        }

        public virtual void Visit(AssignStat assignStat)
        {
            
        }

        public virtual void Visit(FuncDefList funcDefList)
        {
            
        }

        public virtual void Visit(FuncDecl funcDecl)
        {
            
        }

        public virtual void Visit(InherList inherList)
        {
            
        }

        public virtual void Visit(AddOp addOp)
        {
            
        }

        public virtual void Visit(FuncDef funcDef)
        {
            
        }

        public virtual void Visit(ScopeSpec scopeSpec)
        {
            
        }

        public virtual void Visit(ForStat forStat)
        {
            
        }

        public virtual void Visit(Var var)
        {
            
        }

        public virtual void Visit(StatBlock statBlock)
        {
            
        }

        public virtual void Visit(MainStatBlock mainStatBlock)
        {

        }

        public virtual void Visit(Sign sign)
        {
            
        }

        public virtual void Visit(ReturnStat returnStat)
        {
            
        }

        public virtual void Visit(IfStat ifStat)
        {
            
        }

        public virtual void Visit(IndexList indexList)
        {
            
        }

        public virtual void Visit(Not not)
        {
            
        }

        public virtual void Visit(RelExpr relExpr)
        {
            
        }

        public virtual void Visit(MultOp multOp)
        {
            
        }
    }
}
