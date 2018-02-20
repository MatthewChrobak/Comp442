using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;

namespace SyntacticAnalyzer.Derivation
{
    public class Deriver
    {
        public List<(string Rule, string SententialForm)> Derivations;

        public Deriver()
        {
            this.Derivations = new List<(string Rule, string Derivation)> {
                ("$ -> prog", "prog")
            };
        }

        protected void ApplyDerivation(string rule)
        {
            var regex = new Regex(@"\-\>");
            var chunks = regex.Split(rule).Select(val => val.Trim()).ToArray();

            string lastDerivation = this.Derivations.Last().SententialForm;
            string nonTerminal = chunks[0];
            string production = chunks[1] == "EPSILON" ? String.Empty : chunks[1];
            regex = new Regex(nonTerminal);

            if (lastDerivation.IndexOf(nonTerminal) == -1) {
                Console.WriteLine("Could not find " + nonTerminal);
            }

            string newDerivation = regex.Replace(lastDerivation, production, 1).Replace("  ", " ").Trim();
            this.Derivations.Add((rule, newDerivation));
        }
    }
}
