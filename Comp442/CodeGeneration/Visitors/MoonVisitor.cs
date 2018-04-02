using SyntacticAnalyzer.Nodes;
using SyntacticAnalyzer.Semantics;
using System;
using System.IO;

namespace CodeGeneration.Visitors
{
    public class MoonVisitor : Visitor
    {
        private SymbolTable GlobalScope;
        private SymbolTable FunctionScope;
        private SymbolTable ClassInstanceScope;

        public MoonVisitor(SymbolTable globalScope)
        {
            this.GlobalScope = globalScope;

            // Reset the instructions.
            InstructionStream.Instructions.Clear();

            InstructionStream.Add(File.ReadAllLines("puts.m"), "Link the puts library");
        }

        private void LoadValue(Node node, string register)
        {
            InstructionStream.Add($"lw {register}, {node.stackOffset}(r14)", $"Loading the value of {node}");
            
            if (!node.IsLiteral) {
                InstructionStream.Add($"lw {register}, 0({register})", $"Pointer detected. Dereferencing {node}");
            }
        }

        public override void PreVisit(FuncDef funcDef)
        {
            this.FunctionScope = GlobalScope.Get(funcDef.FunctionName, Classification.Function).Link;

            if (funcDef.ScopeResolution != null) {
                this.ClassInstanceScope = this.GlobalScope.Get(funcDef.ScopeResolution.ID, Classification.Class).Link;
            }

            InstructionStream.Add($"fun_{funcDef.FunctionName}  sw 0(r14), r15", "Store the return value");
        }

        public override void Visit(FuncDef funcDef)
        {
            InstructionStream.Add(new string[] {
                "lw r15, 0(r14)",
                "jr r15"
            }, "Load the return address.");
        }

        public override void Visit(ReturnStat returnStat)
        {
            this.LoadValue(returnStat.ReturnValueExpression, "r1");
            InstructionStream.Add($"sw 4(r14), r1", $"Returning {returnStat.ReturnValueExpression}");

            InstructionStream.Add(new string[] {
                "lw r15, 0(r14)",
                "jr r15"
            }, "Load the return address.");
        }

        public override void PreVisit(MainStatBlock mainStatBlock)
        {
            this.FunctionScope = GlobalScope.Get("main", Classification.Function).Link;
            this.ClassInstanceScope = new SymbolTable();
            InstructionStream.Add("entry");
        }

        public override void Visit(MainStatBlock mainStatBlock)
        {
            InstructionStream.Add("hlt");

            int size = InstructionStream.Instructions.Count * 4;

            int indexToInsert = InstructionStream.Instructions.IndexOf("entry") + 1;
            InstructionStream.Instructions.Insert(indexToInsert, $"addi r14, r0, {size}");
        }

        public override void Visit(Integer integer)
        {
            int val = int.Parse(integer.Value);

            byte[] bytes = BitConverter.GetBytes(val);

            for (int i = 0; i < bytes.Length; i++) {
                InstructionStream.Add(new string[] {
                    $"addi r1, r0, {bytes[i]}",
                    $"sb {integer.stackOffset + i}(r14), r1"
                }, $"Storing {bytes[i]}");
            }
        }

        public override void Visit(Sign sign)
        {
            string factor = sign.SignSymbol == "-" ? "-1" : "1";

            InstructionStream.Add(new string[] {
                $"lw r2, {sign.Factor.stackOffset}(r14)",
                $"muli r2, r2, {factor}",
                $"sw {sign.stackOffset}(r14), r2"
            }, $"Calculating {sign}");
        }

        public override void Visit(AddOp addOp)
        {
            string instruction = addOp.Operator == "+" ? "add" : "sub";

            this.LoadValue(addOp.LHS, "r2");
            this.LoadValue(addOp.RHS, "r3");

            InstructionStream.Add(new string[] {
                $"{instruction} r1, r2, r3",
                $"sw {addOp.stackOffset}(r14), r1"
            }, $"Calculating {addOp.ToString()}");
        }

        public override void Visit(MultOp multOp)
        {
            string instruction = multOp.Operator == "*" ? "mul" : "div";

            this.LoadValue(multOp.LHS, "r2");
            this.LoadValue(multOp.RHS, "r3");

            InstructionStream.Add(new string[] {
                $"{instruction} r1, r2, r3",
                $"sw {multOp.stackOffset}(r14), r1"
            }, $"Calculating {multOp.ToString()}");
        }

        public override void Visit(PutStat putStat)
        {
            this.LoadValue(putStat.Expression, "r1");

            InstructionStream.Add($"sw {FunctionScope.GetStackFrameSize() + 4}(r14), r1", $"Store the puts value");
            InstructionStream.Add($"addi r14, r14, {FunctionScope.GetStackFrameSize()}", $"Increase the stack pointer");
            InstructionStream.Add($"jl r15, put_function", $"Make the print call");
            InstructionStream.Add($"subi r14, r14, {FunctionScope.GetStackFrameSize()}", $"Decrease the stack pointer");
        }

        private SymbolTable LocalScope;

        public override void PreVisit(Var var)
        {
            this.LocalScope = new SymbolTable();
            this.LocalScope.AddRange(this.FunctionScope.GetAll(), (0, 0));
            this.LocalScope.AddRange(this.GlobalScope.GetAll(), (0, 0));
        }

        public override void Visit(DataMember dataMember)
        {
            InstructionStream.Add($"addi r1, r14, {dataMember.baseOffset}", $"Get the base offset for {dataMember.Id}");

            if (dataMember?.Indexes?.Expressions != null) {

                var maxIndexes = FunctionScope.Get(dataMember.Id, Classification.Variable).MaxSizeDimensions;

                for (int i = 0; i < dataMember.Indexes.Expressions.Count; i++) {
                    var exp = dataMember.Indexes.Expressions[i];
                    InstructionStream.Add($"lw r2, {exp.stackOffset}(r14)", $"Getting the index [{exp}]");
                    //InstructionStream.Add($"muli r2, r2, {dataMember.NonArrayTypeMemorySize}", $"Multiply by the size.");

                    for (int sizeIndex = i + 1; sizeIndex < dataMember.Indexes.Expressions.Count; sizeIndex++) {
                        InstructionStream.Add($"muli r2, r2, {maxIndexes[sizeIndex]}", $"Multiply by the chunk size {maxIndexes[sizeIndex]}");
                    }

                    InstructionStream.Add($"add r1, r1, r2", $"Add the index {dataMember.Indexes.Expressions[i]}");
                }
            }

            InstructionStream.Add($"sw {dataMember.stackOffset}(r14), r1", $"Save the pointer location for {dataMember}");

            LocalScope = new SymbolTable();
            LocalScope.AddRange(GlobalScope.Get(dataMember.SemanticalType, Classification.Class)?.Link?.GetAll(), dataMember.Location);
        }

        public override void Visit(FCall fCall)
        {
            InstructionStream.Add($"addi r14, r14, {this.FunctionScope.GetStackFrameSize()}", "Increase the stack frame");
            InstructionStream.Add($"jl r15, fun_{fCall.Id}", $"Make the function call to {fCall.Id}");
            InstructionStream.Add($"subi r14, r14, {this.FunctionScope.GetStackFrameSize()}", "Decrease the stack frame");

            InstructionStream.Add($"addi r1, r14, {FunctionScope.GetStackFrameSize() + 4}");
            InstructionStream.Add($"sw {fCall.stackOffset}(r14), r1");
        }

        public override void Visit(Var var)
        {
            InstructionStream.Add("addi r1, r0, 0", $"Calculate the offset for {var}");

            foreach (var entry in var.Elements) {
                if (entry is DataMember member) {

                }

                if (entry is FCall call) {

                }
            }


        }

        public override void Visit(AssignStat assignStat)
        {
            this.LoadValue(assignStat.ExpressionValue, "r1");

            InstructionStream.Add(new string[] {
                $"lw r2, {assignStat.Variable.stackOffset}(r14)",
                $"sw 0(r2), r1"
            }, $"Dereference {assignStat.Variable} and assign it the value of {assignStat.ExpressionValue}");
        }
    }
}
