%{
open Ast
%}

%token TRUE FALSE AND OR NOT
%token PLUS MINUS TIMES DIV MOD
%token EQ LEQ LT GEQ GT
%token LPAREN RPAREN LBRACE RBRACE
%token ASSG COMP SKIP IF ELSE WHILE PRINT INPUT FOR
%token <string> VAR
%token <int> NUMBER
%token EOL

%nonassoc RPAREN RBRACE /* lowest precedence - always reduce */
%nonassoc EQ LEQ LT GEQ GT
%nonassoc VAR
%nonassoc NUMBER
%left PLUS MINUS MOD
%left TIMES DIV
%nonassoc TRUE FALSE
%left AND OR
%nonassoc NOT
%nonassoc COMP
%nonassoc SKIP IF ELSE WHILE PRINT INPUT FOR
%nonassoc ASSG
%nonassoc LPAREN LBRACE /* highest precedence - always shift */

%start main /* entry points */
%type <Ast.com> main

%%

main:
  | comlist EOL { $1 }
;

comlist:
  | com COMP comlist { Comp ($1, $3) }
  | combr comlist { Comp ($1, $2) } /* ends in brace -> doesn't need ; */
  | com COMP { $1 }
  | com { $1 }
  | combr COMP comlist { Comp ($1, $3) }
  | combr COMP { $1 }
;

com:
  | WHILE LPAREN bexp RPAREN com { While ($3, $5) }
  | IF LPAREN bexp RPAREN com ELSE com { Cond ($3, $5, $7) }
  | IF LPAREN bexp RPAREN combr ELSE com { Cond ($3, $5, $7) }
  | FOR LPAREN aexp RPAREN com { For ($3, $5) }
  | VAR ASSG aexp { Assg ($1, $3) }
  | PRINT aexp { Print $2 }
  | SKIP { Skip }
;

combr:
  | LBRACE comlist RBRACE { $2 }
  | WHILE LPAREN bexp RPAREN combr { While ($3, $5) }
  | FOR LPAREN aexp RPAREN combr { For ($3, $5) }
  | IF LPAREN bexp RPAREN com ELSE combr { Cond ($3, $5, $7) }
  | IF LPAREN bexp RPAREN combr ELSE combr { Cond ($3, $5, $7) }
;

aexp:
  | VAR { Var $1 }
  | NUMBER { Number $1 }
  | LPAREN aexp RPAREN { $2 }
  | aexp PLUS aexp { Plus ($1, $3) }
  | aexp MINUS aexp { Minus ($1, $3) }
  | aexp TIMES aexp { Times ($1, $3) }
  | aexp DIV aexp { Div ($1, $3) }
  | aexp MOD aexp { Mod ($1, $3) }
  | MINUS aexp { Minus (Number 0, $2) }
  | INPUT { Input }
;

bexp:
  | aexp EQ aexp { Eq ($1, $3) }
  | aexp LEQ aexp { Leq ($1, $3) }
  | aexp LT aexp { Lt ($1, $3) }
  | aexp GEQ aexp { Leq ($3, $1) }
  | aexp GT aexp { Lt ($3, $1) }
  | LPAREN bexp RPAREN { $2 }
  | NOT bexp { Not $2 }
  | bexp AND bexp { And ($1, $3) }
  | bexp OR bexp { Or ($1, $3) }
  | TRUE { True }
  | FALSE { False }
;

%%
