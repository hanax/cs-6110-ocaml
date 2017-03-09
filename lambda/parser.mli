type token =
  | FUN
  | LET
  | IN
  | EQUAL
  | APP
  | VAR of (string)
  | IMP
  | LPAREN
  | RPAREN
  | EOL

val parse :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Ast.expr_s
