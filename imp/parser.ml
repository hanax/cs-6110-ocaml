type token =
  | TRUE
  | FALSE
  | AND
  | OR
  | NOT
  | PLUS
  | MINUS
  | TIMES
  | DIV
  | MOD
  | EQ
  | LEQ
  | LT
  | GEQ
  | GT
  | LPAREN
  | RPAREN
  | LBRACE
  | RBRACE
  | ASSG
  | COMP
  | SKIP
  | IF
  | ELSE
  | WHILE
  | PRINT
  | INPUT
  | FOR
  | VAR of (string)
  | NUMBER of (int)
  | EOL

open Parsing;;
let _ = parse_error;;
# 1 "parser.mly"

open Ast
# 40 "parser.ml"
let yytransl_const = [|
  257 (* TRUE *);
  258 (* FALSE *);
  259 (* AND *);
  260 (* OR *);
  261 (* NOT *);
  262 (* PLUS *);
  263 (* MINUS *);
  264 (* TIMES *);
  265 (* DIV *);
  266 (* MOD *);
  267 (* EQ *);
  268 (* LEQ *);
  269 (* LT *);
  270 (* GEQ *);
  271 (* GT *);
  272 (* LPAREN *);
  273 (* RPAREN *);
  274 (* LBRACE *);
  275 (* RBRACE *);
  276 (* ASSG *);
  277 (* COMP *);
  278 (* SKIP *);
  279 (* IF *);
  280 (* ELSE *);
  281 (* WHILE *);
  282 (* PRINT *);
  283 (* INPUT *);
  284 (* FOR *);
  287 (* EOL *);
    0|]

let yytransl_block = [|
  285 (* VAR *);
  286 (* NUMBER *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\002\000\002\000\002\000\002\000\002\000\003\000\
\003\000\003\000\003\000\003\000\003\000\003\000\004\000\004\000\
\004\000\004\000\004\000\006\000\006\000\006\000\006\000\006\000\
\006\000\006\000\006\000\006\000\006\000\005\000\005\000\005\000\
\005\000\005\000\005\000\005\000\005\000\005\000\005\000\005\000\
\000\000"

let yylen = "\002\000\
\002\000\003\000\002\000\002\000\001\000\003\000\002\000\005\000\
\007\000\007\000\005\000\003\000\002\000\001\000\003\000\005\000\
\005\000\007\000\007\000\001\000\001\000\003\000\003\000\003\000\
\003\000\003\000\003\000\002\000\001\000\003\000\003\000\003\000\
\003\000\003\000\003\000\002\000\003\000\003\000\001\000\001\000\
\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\014\000\000\000\000\000\000\000\000\000\
\000\000\041\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\029\000\020\000\021\000\000\000\000\000\000\000\
\001\000\000\000\000\000\003\000\015\000\039\000\040\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\002\000\006\000\036\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\022\000\000\000\000\000\025\000\026\000\
\000\000\000\000\035\000\037\000\038\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\008\000\016\000\011\000\017\000\
\000\000\000\000\009\000\018\000\010\000\019\000"

let yydgoto = "\002\000\
\010\000\011\000\012\000\013\000\034\000\035\000"

let yysindex = "\005\000\
\187\255\000\000\187\255\000\000\004\255\007\255\045\255\015\255\
\001\255\000\000\011\255\023\255\178\255\027\255\038\255\038\255\
\045\255\045\255\000\000\000\000\000\000\238\255\045\255\045\255\
\000\000\187\255\187\255\000\000\000\000\000\000\000\000\038\255\
\038\255\005\255\228\255\024\255\252\254\211\255\045\255\045\255\
\045\255\045\255\045\255\216\255\238\255\000\000\000\000\000\000\
\054\255\180\255\038\255\038\255\187\255\045\255\045\255\045\255\
\045\255\045\255\187\255\000\000\252\254\252\254\000\000\000\000\
\252\254\187\255\000\000\000\000\000\000\031\255\040\255\238\255\
\238\255\238\255\238\255\238\255\000\000\000\000\000\000\000\000\
\187\255\187\255\000\000\000\000\000\000\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\240\254\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\075\255\000\000\000\000\
\000\000\249\254\250\254\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\076\255\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\097\255\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\098\255\120\255\000\000\000\000\
\142\255\000\000\000\000\000\000\000\000\000\000\000\000\056\255\
\161\255\164\255\166\255\168\255\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\050\000\204\255\003\000\242\255\249\255"

let yytablesize = 248
let yytable = "\022\000\
\070\000\036\000\005\000\041\000\042\000\001\000\077\000\051\000\
\052\000\037\000\038\000\004\000\007\000\079\000\005\000\044\000\
\045\000\048\000\049\000\015\000\024\000\053\000\016\000\004\000\
\007\000\050\000\051\000\052\000\083\000\085\000\023\000\061\000\
\062\000\063\000\064\000\065\000\068\000\069\000\030\000\031\000\
\059\000\025\000\032\000\026\000\017\000\029\000\072\000\073\000\
\074\000\075\000\076\000\017\000\014\000\033\000\081\000\071\000\
\051\000\052\000\030\000\030\000\018\000\078\000\028\000\082\000\
\019\000\000\000\020\000\021\000\080\000\000\000\067\000\019\000\
\030\000\020\000\021\000\046\000\047\000\000\000\028\000\028\000\
\000\000\028\000\028\000\084\000\086\000\028\000\028\000\028\000\
\028\000\028\000\028\000\000\000\028\000\013\000\028\000\013\000\
\028\000\000\000\013\000\028\000\023\000\023\000\000\000\023\000\
\023\000\013\000\028\000\023\000\023\000\023\000\023\000\023\000\
\023\000\000\000\023\000\012\000\023\000\012\000\023\000\000\000\
\012\000\023\000\024\000\024\000\000\000\024\000\024\000\012\000\
\023\000\024\000\024\000\024\000\024\000\024\000\024\000\000\000\
\024\000\000\000\024\000\000\000\024\000\000\000\000\000\024\000\
\027\000\027\000\000\000\027\000\027\000\000\000\024\000\027\000\
\027\000\027\000\027\000\027\000\027\000\000\000\027\000\000\000\
\027\000\000\000\027\000\031\000\031\000\027\000\032\000\032\000\
\033\000\033\000\034\000\034\000\027\000\000\000\000\000\000\000\
\000\000\031\000\000\000\000\000\032\000\000\000\033\000\000\000\
\034\000\039\000\040\000\041\000\042\000\043\000\054\000\055\000\
\056\000\057\000\058\000\003\000\060\000\000\000\027\000\004\000\
\005\000\000\000\006\000\007\000\003\000\008\000\009\000\000\000\
\004\000\005\000\000\000\006\000\007\000\000\000\008\000\009\000\
\039\000\040\000\041\000\042\000\043\000\039\000\040\000\041\000\
\042\000\043\000\000\000\060\000\000\000\000\000\000\000\000\000\
\066\000\039\000\040\000\041\000\042\000\043\000\054\000\055\000\
\056\000\057\000\058\000\039\000\040\000\041\000\042\000\043\000"

let yycheck = "\007\000\
\053\000\016\000\019\001\008\001\009\001\001\000\059\000\003\001\
\004\001\017\000\018\000\019\001\019\001\066\000\031\001\023\000\
\024\000\032\000\033\000\016\001\020\001\017\001\016\001\031\001\
\031\001\033\000\003\001\004\001\081\000\082\000\016\001\039\000\
\040\000\041\000\042\000\043\000\051\000\052\000\001\001\002\001\
\017\001\031\001\005\001\021\001\007\001\019\001\054\000\055\000\
\056\000\057\000\058\000\007\001\003\000\016\001\024\001\053\000\
\003\001\004\001\003\001\004\001\016\001\059\000\013\000\024\001\
\027\001\255\255\029\001\030\001\066\000\255\255\017\001\027\001\
\017\001\029\001\030\001\026\000\027\000\255\255\003\001\004\001\
\255\255\006\001\007\001\081\000\082\000\010\001\011\001\012\001\
\013\001\014\001\015\001\255\255\017\001\019\001\019\001\021\001\
\021\001\255\255\024\001\024\001\003\001\004\001\255\255\006\001\
\007\001\031\001\031\001\010\001\011\001\012\001\013\001\014\001\
\015\001\255\255\017\001\019\001\019\001\021\001\021\001\255\255\
\024\001\024\001\003\001\004\001\255\255\006\001\007\001\031\001\
\031\001\010\001\011\001\012\001\013\001\014\001\015\001\255\255\
\017\001\255\255\019\001\255\255\021\001\255\255\255\255\024\001\
\003\001\004\001\255\255\006\001\007\001\255\255\031\001\010\001\
\011\001\012\001\013\001\014\001\015\001\255\255\017\001\255\255\
\019\001\255\255\021\001\003\001\004\001\024\001\003\001\004\001\
\003\001\004\001\003\001\004\001\031\001\255\255\255\255\255\255\
\255\255\017\001\255\255\255\255\017\001\255\255\017\001\255\255\
\017\001\006\001\007\001\008\001\009\001\010\001\011\001\012\001\
\013\001\014\001\015\001\018\001\017\001\255\255\021\001\022\001\
\023\001\255\255\025\001\026\001\018\001\028\001\029\001\255\255\
\022\001\023\001\255\255\025\001\026\001\255\255\028\001\029\001\
\006\001\007\001\008\001\009\001\010\001\006\001\007\001\008\001\
\009\001\010\001\255\255\017\001\255\255\255\255\255\255\255\255\
\017\001\006\001\007\001\008\001\009\001\010\001\011\001\012\001\
\013\001\014\001\015\001\006\001\007\001\008\001\009\001\010\001"

let yynames_const = "\
  TRUE\000\
  FALSE\000\
  AND\000\
  OR\000\
  NOT\000\
  PLUS\000\
  MINUS\000\
  TIMES\000\
  DIV\000\
  MOD\000\
  EQ\000\
  LEQ\000\
  LT\000\
  GEQ\000\
  GT\000\
  LPAREN\000\
  RPAREN\000\
  LBRACE\000\
  RBRACE\000\
  ASSG\000\
  COMP\000\
  SKIP\000\
  IF\000\
  ELSE\000\
  WHILE\000\
  PRINT\000\
  INPUT\000\
  FOR\000\
  EOL\000\
  "

let yynames_block = "\
  VAR\000\
  NUMBER\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'comlist) in
    Obj.repr(
# 34 "parser.mly"
                ( _1 )
# 250 "parser.ml"
               : Ast.com))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'com) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'comlist) in
    Obj.repr(
# 38 "parser.mly"
                     ( Comp (_1, _3) )
# 258 "parser.ml"
               : 'comlist))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'combr) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'comlist) in
    Obj.repr(
# 39 "parser.mly"
                  ( Comp (_1, _2) )
# 266 "parser.ml"
               : 'comlist))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'com) in
    Obj.repr(
# 40 "parser.mly"
             ( _1 )
# 273 "parser.ml"
               : 'comlist))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'com) in
    Obj.repr(
# 41 "parser.mly"
        ( _1 )
# 280 "parser.ml"
               : 'comlist))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'combr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'comlist) in
    Obj.repr(
# 42 "parser.mly"
                       ( Comp (_1, _3) )
# 288 "parser.ml"
               : 'comlist))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'combr) in
    Obj.repr(
# 43 "parser.mly"
               ( _1 )
# 295 "parser.ml"
               : 'comlist))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 2 : 'bexp) in
    let _5 = (Parsing.peek_val __caml_parser_env 0 : 'com) in
    Obj.repr(
# 47 "parser.mly"
                                 ( While (_3, _5) )
# 303 "parser.ml"
               : 'com))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 4 : 'bexp) in
    let _5 = (Parsing.peek_val __caml_parser_env 2 : 'com) in
    let _7 = (Parsing.peek_val __caml_parser_env 0 : 'com) in
    Obj.repr(
# 48 "parser.mly"
                                       ( Cond (_3, _5, _7) )
# 312 "parser.ml"
               : 'com))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 4 : 'bexp) in
    let _5 = (Parsing.peek_val __caml_parser_env 2 : 'combr) in
    let _7 = (Parsing.peek_val __caml_parser_env 0 : 'com) in
    Obj.repr(
# 49 "parser.mly"
                                         ( Cond (_3, _5, _7) )
# 321 "parser.ml"
               : 'com))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 2 : 'aexp) in
    let _5 = (Parsing.peek_val __caml_parser_env 0 : 'com) in
    Obj.repr(
# 50 "parser.mly"
                               ( For (_3, _5) )
# 329 "parser.ml"
               : 'com))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'aexp) in
    Obj.repr(
# 51 "parser.mly"
                  ( Assg (_1, _3) )
# 337 "parser.ml"
               : 'com))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'aexp) in
    Obj.repr(
# 52 "parser.mly"
               ( Print _2 )
# 344 "parser.ml"
               : 'com))
; (fun __caml_parser_env ->
    Obj.repr(
# 53 "parser.mly"
         ( Skip )
# 350 "parser.ml"
               : 'com))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'comlist) in
    Obj.repr(
# 57 "parser.mly"
                          ( _2 )
# 357 "parser.ml"
               : 'combr))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 2 : 'bexp) in
    let _5 = (Parsing.peek_val __caml_parser_env 0 : 'combr) in
    Obj.repr(
# 58 "parser.mly"
                                   ( While (_3, _5) )
# 365 "parser.ml"
               : 'combr))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 2 : 'aexp) in
    let _5 = (Parsing.peek_val __caml_parser_env 0 : 'combr) in
    Obj.repr(
# 59 "parser.mly"
                                 ( For (_3, _5) )
# 373 "parser.ml"
               : 'combr))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 4 : 'bexp) in
    let _5 = (Parsing.peek_val __caml_parser_env 2 : 'com) in
    let _7 = (Parsing.peek_val __caml_parser_env 0 : 'combr) in
    Obj.repr(
# 60 "parser.mly"
                                         ( Cond (_3, _5, _7) )
# 382 "parser.ml"
               : 'combr))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 4 : 'bexp) in
    let _5 = (Parsing.peek_val __caml_parser_env 2 : 'combr) in
    let _7 = (Parsing.peek_val __caml_parser_env 0 : 'combr) in
    Obj.repr(
# 61 "parser.mly"
                                           ( Cond (_3, _5, _7) )
# 391 "parser.ml"
               : 'combr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 65 "parser.mly"
        ( Var _1 )
# 398 "parser.ml"
               : 'aexp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 66 "parser.mly"
           ( Number _1 )
# 405 "parser.ml"
               : 'aexp))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'aexp) in
    Obj.repr(
# 67 "parser.mly"
                       ( _2 )
# 412 "parser.ml"
               : 'aexp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'aexp) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'aexp) in
    Obj.repr(
# 68 "parser.mly"
                   ( Plus (_1, _3) )
# 420 "parser.ml"
               : 'aexp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'aexp) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'aexp) in
    Obj.repr(
# 69 "parser.mly"
                    ( Minus (_1, _3) )
# 428 "parser.ml"
               : 'aexp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'aexp) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'aexp) in
    Obj.repr(
# 70 "parser.mly"
                    ( Times (_1, _3) )
# 436 "parser.ml"
               : 'aexp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'aexp) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'aexp) in
    Obj.repr(
# 71 "parser.mly"
                  ( Div (_1, _3) )
# 444 "parser.ml"
               : 'aexp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'aexp) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'aexp) in
    Obj.repr(
# 72 "parser.mly"
                  ( Mod (_1, _3) )
# 452 "parser.ml"
               : 'aexp))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'aexp) in
    Obj.repr(
# 73 "parser.mly"
               ( Minus (Number 0, _2) )
# 459 "parser.ml"
               : 'aexp))
; (fun __caml_parser_env ->
    Obj.repr(
# 74 "parser.mly"
          ( Input )
# 465 "parser.ml"
               : 'aexp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'aexp) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'aexp) in
    Obj.repr(
# 78 "parser.mly"
                 ( Eq (_1, _3) )
# 473 "parser.ml"
               : 'bexp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'aexp) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'aexp) in
    Obj.repr(
# 79 "parser.mly"
                  ( Leq (_1, _3) )
# 481 "parser.ml"
               : 'bexp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'aexp) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'aexp) in
    Obj.repr(
# 80 "parser.mly"
                 ( Lt (_1, _3) )
# 489 "parser.ml"
               : 'bexp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'aexp) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'aexp) in
    Obj.repr(
# 81 "parser.mly"
                  ( Leq (_3, _1) )
# 497 "parser.ml"
               : 'bexp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'aexp) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'aexp) in
    Obj.repr(
# 82 "parser.mly"
                 ( Lt (_3, _1) )
# 505 "parser.ml"
               : 'bexp))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'bexp) in
    Obj.repr(
# 83 "parser.mly"
                       ( _2 )
# 512 "parser.ml"
               : 'bexp))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'bexp) in
    Obj.repr(
# 84 "parser.mly"
             ( Not _2 )
# 519 "parser.ml"
               : 'bexp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'bexp) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'bexp) in
    Obj.repr(
# 85 "parser.mly"
                  ( And (_1, _3) )
# 527 "parser.ml"
               : 'bexp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'bexp) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'bexp) in
    Obj.repr(
# 86 "parser.mly"
                 ( Or (_1, _3) )
# 535 "parser.ml"
               : 'bexp))
; (fun __caml_parser_env ->
    Obj.repr(
# 87 "parser.mly"
         ( True )
# 541 "parser.ml"
               : 'bexp))
; (fun __caml_parser_env ->
    Obj.repr(
# 88 "parser.mly"
          ( False )
# 547 "parser.ml"
               : 'bexp))
(* Entry main *)
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
let main (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : Ast.com)
;;
# 91 "parser.mly"

# 574 "parser.ml"
