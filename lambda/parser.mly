%{
open Ast

let elist (s : expr_s list) : expr_s =
  match s with
    | [x] -> x
    | x :: t -> List.fold_left (fun a y -> App_s (a, y)) x t
    | _ -> failwith "Empty expression list"
%}

%token FUN LET IN EQUAL
%token APP
%token <string> VAR
%token IMP
%token LPAREN RPAREN
%token EOL

%nonassoc RPAREN /* lowest precedence - always reduce */
%left APP
%nonassoc VAR
%nonassoc LPAREN FUN LET /* highest precedence - always shift */

%start parse /* entry points */
%type <Ast.expr_s> parse

%%

parse:
  | exprlist EOL { elist $1 }
;

exprlist:
  | expr exprlist %prec APP { $1 :: $2 }
  | expr %prec APP { [$1] }
;

varlist:
  | VAR { [$1] }
  | VAR varlist { $1 :: $2 }
;

expr:
  | VAR { Var_s $1 }
  | LPAREN exprlist RPAREN { elist $2 }
  | FUN varlist IMP exprlist %prec RPAREN { Fun_s ($2, elist $4) }
  | LET VAR EQUAL exprlist IN exprlist %prec RPAREN { Let_s ($2, elist $4, elist $6) }
;

%%


