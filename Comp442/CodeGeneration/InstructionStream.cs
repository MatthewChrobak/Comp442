﻿using System;
using System.Collections.Generic;

namespace CodeGeneration
{
    public class InstructionStream
    {
        public static List<string> Instructions = new List<string>();
        private static string NextLineIdentifier = string.Empty;

        public static void Add(string entry, string comment = "")
        {
            entry = NextLineIdentifier + entry;

            if (comment.Length != 0) {
                entry += $"\t% {comment}";
            }
            Instructions.Add(entry);

            NextLineIdentifier = string.Empty;
        }

        public static void Add(string[] v, string comment = "")
        {
            for (int i = 0; i < v.Length; i++) {
                if (i == 0) {
                    Add(v[i], comment);
                } else {
                    Add(v[i]);
                }
            }
        }

        public static void AddIdentifierToNextInsert(string identifier)
        {
            InstructionStream.NextLineIdentifier = identifier;
        }
    }
}
