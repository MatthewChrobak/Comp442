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

        public override void Visit(AssignStat assignStat)
        {
            InstructionStream.Add($"lw r1, {assignStat.ExpressionValue.offset}(r14)", assignStat.ToString()); // Load the result into r1
            InstructionStream.Add($"sw {assignStat.Variable.offset}(r14), r1");
        }

        public override void Visit(PutStat putStat)
        {
            InstructionStream.Add($"lw r1, {putStat.Expression.offset}(r14)", putStat.ToString());
            InstructionStream.Add($"putc r1");
        }
    }
}
