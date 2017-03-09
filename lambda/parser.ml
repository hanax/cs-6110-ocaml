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

open Parsing;;
let _ = parse_error;;
# 2 "parser.mly"
open Ast

let elist (s : expr_s list) : expr_s =
  match s with
    | [x] -> x
    | x :: t -> List.fold_left (fun a y -> App_s (a, y)) x t
    | _ -> failwith "Empty expression list"
# 24 "parser.ml"
let yytransl_const = [|
  257 (* FUN *);
  258 (* LET *);
  259 (* IN *);
  260 (* EQUAL *);
  261 (* APP *);
  263 (* IMP *);
  264 (* LPAREN *);
  265 (* RPAREN *);
  266 (* EOL *);
    0|]

let yytransl_block = [|
  262 (* VAR *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\002\000\004\000\004\000\003\000\003\000\003\000\
\003\000\000\000"

let yylen = "\002\000\
\002\000\002\000\001\000\001\000\002\000\001\000\003\000\004\000\
\006\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\000\000\006\000\000\000\010\000\000\000\
\000\000\000\000\000\000\000\000\000\000\001\000\002\000\005\000\
\000\000\000\000\007\000\008\000\000\000\000\000\009\000"

let yydgoto = "\002\000\
\007\000\008\000\009\000\011\000"

let yysindex = "\003\000\
\000\255\000\000\255\254\003\255\000\000\000\255\000\000\005\255\
\000\255\255\254\010\255\006\255\009\255\000\000\000\000\000\000\
\000\255\000\255\000\000\000\000\016\255\000\255\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\004\255\013\255\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\250\255\000\000\011\000"

let yytablesize = 21
let yytable = "\013\000\
\003\000\004\000\015\000\001\000\010\000\005\000\003\000\006\000\
\012\000\018\000\020\000\021\000\003\000\003\000\014\000\023\000\
\017\000\019\000\022\000\004\000\016\000"

let yycheck = "\006\000\
\001\001\002\001\009\000\001\000\006\001\006\001\003\001\008\001\
\006\001\004\001\017\000\018\000\009\001\010\001\010\001\022\000\
\007\001\009\001\003\001\007\001\010\000"

let yynames_const = "\
  FUN\000\
  LET\000\
  IN\000\
  EQUAL\000\
  APP\000\
  IMP\000\
  LPAREN\000\
  RPAREN\000\
  EOL\000\
  "

let yynames_block = "\
  VAR\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'exprlist) in
    Obj.repr(
# 29 "parser.mly"
                 ( elist _1 )
# 104 "parser.ml"
               : Ast.expr_s))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'exprlist) in
    Obj.repr(
# 33 "parser.mly"
                            ( _1 :: _2 )
# 112 "parser.ml"
               : 'exprlist))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 34 "parser.mly"
                   ( [_1] )
# 119 "parser.ml"
               : 'exprlist))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 38 "parser.mly"
        ( [_1] )
# 126 "parser.ml"
               : 'varlist))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : string) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'varlist) in
    Obj.repr(
# 39 "parser.mly"
                ( _1 :: _2 )
# 134 "parser.ml"
               : 'varlist))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 43 "parser.mly"
        ( Var_s _1 )
# 141 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'exprlist) in
    Obj.repr(
# 44 "parser.mly"
                           ( elist _2 )
# 148 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : 'varlist) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'exprlist) in
    Obj.repr(
# 45 "parser.mly"
                                          ( Fun_s (_2, elist _4) )
# 156 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'exprlist) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : 'exprlist) in
    Obj.repr(
# 46 "parser.mly"
                                                    ( Let_s (_2, elist _4, elist _6) )
# 165 "parser.ml"
               : 'expr))
(* Entry parse *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let parse (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : Ast.expr_s)
;;
# 50 "parser.mly"


# 193 "parser.ml"
