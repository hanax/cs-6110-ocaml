(* Lexer for the FL language. *)

{
open Parser
}

let alph = ['a'-'z' 'A'-'Z']
let rest = ['a'-'z' 'A'-'Z' '0'-'9' '\'']*
let num = ['0'-'9'] ['0'-'9']*
rule token = parse
  | [' ' '\t' '\n' '\r'] { token lexbuf } (* skip whitespace *)
  | "fun"  { FUN }
  | "let"  { LET }
  | "rec"  { REC }
  | "in"   { IN }
  | "true"  { TRUE }
  | "false" { FALSE }
  | "if"    { IF }
  | "then"  { THEN }
  | "else"  { ELSE }
  | alph rest as id { VAR id }
  | num as num { NUM (int_of_string num) }
  | "->"   { IMP }
  | '&'    { AND }
  | '|'    { OR }
  | '~'    { NOT }
  | '+'    { PLUS }
  | '-'    { MINUS }
  | '*'    { TIMES }
  | '/'    { DIV }
  | '%'    { MOD }
  | '='    { EQ }
  | "<="   { LEQ }
  | '<'    { LT }
  | ">="   { GEQ }
  | '>'    { GT }
  | '('    { LPAREN }
  | ')'    { RPAREN }
  | eof    { EOF }
