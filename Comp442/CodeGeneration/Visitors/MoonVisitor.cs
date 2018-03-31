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

            byte[] bytes;
            var shorts = new short[2];
            
            using (var ms = new MemoryStream()) {
                using (var w = new BinaryWriter(ms)) {
                    w.Write(val);
                }
                bytes = ms.ToArray();
            }

            using (var ms = new MemoryStream(bytes)) {
                using (var r = new BinaryReader(ms)) {
                    shorts[0] = r.ReadInt16();
                    shorts[1] = r.ReadInt16();
                }
            }
            
            InstructionStream.Add($"addi r2, r0, {shorts[1]}", $"Storing {integer.Value}");
            InstructionStream.Add("sl r2, 16");
            InstructionStream.Add($"addi r3, r0, {shorts[0]}");


            InstructionStream.Add($"add r1, r2, r3");
            InstructionStream.Add($"sw {integer.stackOffset}(r14), r1");
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
            InstructionStream.Add($"putc r1", $"Printing {putStat.Expression}");
        }

        public override void Visit(DataMember dataMember)
        {
            InstructionStream.Add($"addi r1, r14, {dataMember.baseOffset}", $"Get the base offset for {dataMember.Id}");

            if (dataMember?.Indexes?.Expressions != null) {

                var maxIndexes = FunctionScope.Get(dataMember.Id, Classification.Variable).MaxSizeDimensions;

                for (int i = 0; i < dataMember.Indexes.Expressions.Count; i++) {
                    var exp = dataMember.Indexes.Expressions[i];
                    InstructionStream.Add($"lw r2, {exp.stackOffset}(r14)", $"Getting the index [{exp}]");
                    InstructionStream.Add($"muli r2, r2, {dataMember.NonArrayTypeMemorySize}", $"Multiply by the size.");

                    for (int sizeIndex = i + 1; sizeIndex < dataMember.Indexes.Expressions.Count; sizeIndex++) {
                        InstructionStream.Add($"muli r2, r2, {maxIndexes[sizeIndex]}", $"Multiply by the chunk size {maxIndexes[sizeIndex]}");
                    }

                    InstructionStream.Add($"add r1, r1, r2", $"Add the index {dataMember.Indexes.Expressions[i]}");
                }
            }

            InstructionStream.Add($"sw {dataMember.stackOffset}(r14), r1", $"Save the pointer location for {dataMember}");
        }

        public override void Visit(Var var)
        {
            if (var.Elements.Count > 0) {

            }
        }

        public override void Visit(AssignStat assignStat)
        {
            this.LoadValue(assignStat.ExpressionValue, "r1");

            InstructionStream.Add(new string[] {
                $"lw r2 {assignStat.Variable.stackOffset}",
                $"sw 0(r2), r1"
            }, $"Dereference {assignStat.Variable} and assign it the value of {assignStat.ExpressionValue}");
        }
    }
}
