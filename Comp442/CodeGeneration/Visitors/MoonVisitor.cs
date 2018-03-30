using SyntacticAnalyzer.Nodes;
using SyntacticAnalyzer.Semantics;
using System;
using System.IO;

namespace CodeGeneration.Visitors
{
    public class MoonVisitor : Visitor
    {
        private SymbolTable GlobalScope;

        public MoonVisitor(SymbolTable globalScope)
        {
            this.GlobalScope = globalScope;

            // Reset the instructions.
            InstructionStream.Instructions.Clear();
        }


        public override void PreVisit(MainStatBlock mainStatBlock)
        {
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
            InstructionStream.Add($"sw {integer.offset}(r14), r1");
        }

        public override void Visit(AddOp addOp)
        {
            string instruction = addOp.Operator == "+" ? "add" : "sub";

            InstructionStream.Add(new string[] {
                $"lw r2, {addOp.LHS.offset}(r14)",
                $"lw r3, {addOp.RHS.offset}(r14)",
                $"{instruction} r1, r2, r3",
                $"sw {addOp.offset}(r14), r1"
            }, $"Calculating {addOp.ToString()}");
        }

        public override void Visit(MultOp multOp)
        {
            string instruction = multOp.Operator == "*" ? "mul" : "div";

            InstructionStream.Add(new string[] {
                $"lw r2, {multOp.LHS.offset}(r14)",
                $"lw r3, {multOp.RHS.offset}(r14)",
                $"{instruction} r1, r2, r3",
                $"sw {multOp.offset}(r14), r1"
            }, $"Calculating {multOp.ToString()}");
        }

        public override void Visit(DataMember dataMember)
        {
            InstructionStream.Add($"lw r1, {dataMember.baseOffset}(r14)", $"Loading base value for {dataMember}");

            if (dataMember?.Indexes?.Expressions?.Count != 0) {
                foreach (var exp in dataMember.Indexes.Expressions) {
                    InstructionStream.Add(new string[] {
                        $"lw r2, {exp.offset}(r14)",
                        $"muli r2, r2, 4",
                        $"add r1, r1, r2"
                    }, $"Adding to the base value the offset of {exp}");
                }
            }

            InstructionStream.Add($"sw {dataMember.offset}(r14), r1", $"");
        }

        public override void Visit(Var var)
        {
            InstructionStream.Add($"add r1, r0, r14");

            foreach (var entry in var.Elements) {
                InstructionStream.Add(new string[] {
                    $"lw r2, {entry.offset}(r14)",
                    $"add r1, r1, r2"
                });
            }

            InstructionStream.Add($"sw {var.offset}(r14), r1", $"Storing the ACTUAL value for {var}");
        }

        public override void Visit(AssignStat assignStat)
        {
            InstructionStream.Add($"lw r1, {assignStat.ExpressionValue.offset}(r14)", $"Load the value of {assignStat.ExpressionValue}");

            if (!assignStat.ExpressionValue.IsLiteral) {
                InstructionStream.Add($"lw r1, 0(r1)", "Pointer detected - get the literal value.");
            }

            InstructionStream.Add(new string[] {
                $"lw r2, {assignStat.Variable.offset}(r14)",
                $"sw 0(r2), r1"
            }, $"Dereference {assignStat.Variable} and assign it the value of {assignStat.ExpressionValue}");
        }

        public override void Visit(PutStat putStat)
        {
            InstructionStream.Add($"lw r1, {putStat.Expression.offset}(r14)", putStat.ToString());

            // If the expression is not a literal value, what we loaded into r1 is a pointer. Get its value.
            if (!putStat.Expression.IsLiteral) {
                InstructionStream.Add($"lw r1, 0(r1)", "Pointer detected - get the literal value.");
            }

            InstructionStream.Add($"putc r1");
        }
    }
}
