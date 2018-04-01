using SyntacticAnalyzer.Nodes;
using SyntacticAnalyzer.Semantics;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CodeGeneration.Visitors
{
    public class NewMoonVisitor : Visitor
    {
        private SymbolTable GlobalScope;
        private SymbolTable FunctionScope;
        private SymbolTable ClassInstanceScope;

        public NewMoonVisitor(SymbolTable globalScope)
        {
            this.GlobalScope = globalScope;

            // Reset the instructions.
            InstructionStream.Instructions.Clear();
            InstructionStream.Add(File.ReadAllLines("puts.m").Where(line => line.Trim().Length != 0).ToArray(), "Link the puts library");
        }

        private void Load(Node node, string register)
        {
            InstructionStream.Add($"lw {register}, {node.stackOffset}(r14)", $"Loading the value of {node}");

            if (!node.IsLiteral) {
                InstructionStream.Add($"lw {register}, 0({register})", $"Pointer detected. Dereferencing {node}");
            }
        }

        private void LoadAndStore(int sourceAddresss, int destinationAddress, int copySizeInBytes, bool derefSource = false, bool derefDest = false, string comment = "")
        {
            for (int i = 0; i < copySizeInBytes; i += 4) {
                InstructionStream.Add($"lw r1, {sourceAddresss + (i)}(r14)", $"{comment} - loading {i} of {copySizeInBytes}");
                if (derefSource) {
                    InstructionStream.Add("lw r1, 0(r1)", "Pointer detected. Dereferencing.");
                }
                InstructionStream.Add($"lw r2, {destinationAddress}(r14)");
                if (derefDest) {
                    InstructionStream.Add($"sw 0(r2), r1", "Pointer detected. Storing the value in the dereferenced location.");
                } else {
                    InstructionStream.Add($"sw {destinationAddress + (i)}(r14), r1", $"{comment} - storing {i} of {copySizeInBytes}");
                }
            }
        }

        private void LoadAndStore(Node source, Node destination, int sizeInWords, string comment = "")
        {
            this.LoadAndStore(source.stackOffset, destination.stackOffset, sizeInWords, !source.IsLiteral, !destination.IsLiteral, comment);
        }

        private void LoadAndStore(Node source, int destinationAddress, int sizeInWords, string comment = "")
        {
            this.LoadAndStore(source.stackOffset, destinationAddress, sizeInWords, !source.IsLiteral, false, comment);
        }

        private void LoadAndStore(int sourceAddress, Node destination, int sizeInWords, string comment = "")
        {
            this.LoadAndStore(sourceAddress, destination.stackOffset, sizeInWords, false, !destination.IsLiteral, comment);
        }



        public override void PreVisit(FuncDef funcDef)
        {
            this.FunctionScope = this.GlobalScope.Get(funcDef.Entry.ID, Classification.Function).Link;

            this.ClassInstanceScope = new SymbolTable();
            if (funcDef.ScopeResolution != null) {
                this.ClassInstanceScope = this.GlobalScope.Get(funcDef.ScopeResolution.ID.Replace(':', '_'), Classification.Class).Link;
            }

            InstructionStream.Add($"function_{funcDef.Entry.ID.Replace(':', '_')} sw 0(r14), r15", $"Store the return address.");
        }

        public override void Visit(FuncDef funcDef)
        {
            InstructionStream.Add(new string[] {
                "lw r15, 0(r14)",
                "jr r15"
            }, "Load the return address, and return.");
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

            int programSize = InstructionStream.Instructions.Count * 4;
            int indexToInsert = InstructionStream.Instructions.IndexOf("entry") + 1;
            InstructionStream.Instructions.Insert(indexToInsert, $"addi r14, r0, {programSize}  % Set the stack pointer");
        }


        public override void Visit(Integer integer)
        {
            var bytes = BitConverter.GetBytes(int.Parse(integer.Value));

            for (int i = 0; i < bytes.Length; i++) {
                InstructionStream.Add(new string[] {
                    $"addi r1, r0, {bytes[i]}",
                    $"sb {integer.stackOffset + i}(r14), r1"
                }, $"Storing {bytes[i]}");
            }
        }

        public override void Visit(Sign sign)
        {
            int factor = sign.SignSymbol == "-" ? -1 : 1;

            InstructionStream.Add(new string[] {
                $"lw r2, {sign.Factor.stackOffset}(r14)",
                $"muli r2, r2, {factor}",
                $"sw {sign.stackOffset}(r14), r2"
            }, $"Calculating {sign}");
        }

        public override void Visit(AddOp addOp)
        {
            string instruction = addOp.Operator == "+" ? "add" : "sub";

            this.Load(addOp.LHS, "r2");
            this.Load(addOp.RHS, "r3");

            InstructionStream.Add(new string[] {
                $"{instruction} r1, r2, r3",
                $"sw {addOp.stackOffset}(r14), r1"
            }, $"Calculating {addOp.ToString()}");
        }

        public override void Visit(MultOp multOp)
        {
            string instruction = multOp.Operator == "*" ? "mul" : "div";

            this.Load(multOp.LHS, "r2");
            this.Load(multOp.RHS, "r3");

            InstructionStream.Add(new string[] {
                $"{instruction} r1, r2, r3",
                $"sw {multOp.stackOffset}(r14), r1"
            }, $"Calculating {multOp.ToString()}");
        }



        public override void Visit(DataMember dataMember)
        {
            InstructionStream.Add($"addi r1, r0, {dataMember.baseOffset}", $"Start to calculate the offset for {dataMember}");

            if (dataMember?.Indexes?.Expressions != null) {

            }

            //InstructionStream.Add($"% The data member {dataMember}'s base pointer is contained in r1.");

            for (int i = 0; i < dataMember.NodeMemorySize; i += 4) {
                if (i != 0) {
                    InstructionStream.Add($"addi r1, r1, 4");
                }
                InstructionStream.Add($"sw {dataMember.stackOffset + i}(r14), r1");
            }
        }

        public override void Visit(Var var)
        {
            InstructionStream.Add($"addi r1, r14, 0", $"Calculating the REAL offset for {var}");

            foreach (var entry in var.Elements) {
                if (entry is DataMember member) {
                    InstructionStream.Add(new string[] {
                        $"lw r2, {member.stackOffset}(r14)",
                        $"add r1, r1, r2"
                    });
                }

                if (entry is FCall call) {

                }
            }

            for (int i = 0; i < var.NodeMemorySize; i += 4) {
                if (i != 0) {
                    InstructionStream.Add($"addi r1, r1, 4");
                }
                InstructionStream.Add($"sw {var.stackOffset + i}(r14), r1");
            }
        }



        public override void Visit(PutStat putStat)
        {
            int thisFrameSize = this.FunctionScope.GetStackFrameSize();

            this.LoadAndStore(putStat.Expression, thisFrameSize + 4, putStat.Expression.NodeMemorySize, $"Store the put value of {putStat.Expression}");
            InstructionStream.Add($"addi r14, r14, {thisFrameSize}");
            InstructionStream.Add($"jl r15, puti_func");
            InstructionStream.Add($"subi r14, r14, {thisFrameSize}");
        }

        public override void Visit(AssignStat assignStat)
        {
            this.LoadAndStore(assignStat.ExpressionValue, assignStat.Variable, assignStat.ExpressionValue.NodeMemorySize, $"{assignStat}");
        }
    }
}
