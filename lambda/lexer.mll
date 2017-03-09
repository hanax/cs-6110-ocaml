{
open Parser
}

let lower = ['a'-'z']
let rest = ['a'-'z' 'A'-'Z' '0'-'9' '\'']*
rule token = parse
  | [' ' '\t'] { token lexbuf } (* skip whitespace *)
  | "fun"  { FUN }
  | "let"  { LET }
  | "in"   { IN }
  | lower rest as id { VAR id }
  | "->"   { IMP }
  | '='    { EQUAL }
  | '('    { LPAREN }
  | ')'    { RPAREN }
  | eof    { EOL }
