%{
open Ast
%}

%token FUN LET REC IN
%token APP
%token <string> VAR
%token IMP
%token LPAREN RPAREN
%token TRUE FALSE AND OR NOT
%token PLUS MINUS TIMES DIV MOD
%token EQ LEQ LT GEQ GT
%token IF THEN ELSE
%token <string> VAR
%token <int> NUM
%token EOF

%start main 
%type <Ast.exp> main

%%

main:
  | exp EOF { $1 }

exp:
  | FUN var_list IMP exp { Fun($2,$4) }
  | IF exp THEN exp ELSE exp { Cond($2,$4,$6) }
  | LET var_list EQ exp IN exp { Let($2,$4,$6) }      
  | LET REC var_list EQ exp IN exp { Letrec($3,$5,$7) }
  | compare_exp { $1 }

var_list:
  | VAR { [$1] }
  | VAR var_list { $1 :: $2 }

compare_exp:
  | infix_exp EQ infix_exp { Eq($1,$3) }
  | infix_exp LEQ infix_exp { Leq($1,$3) }
  | infix_exp LT infix_exp { Lt($1,$3) }
  | infix_exp GEQ infix_exp { Leq($3,$1) }
  | infix_exp GT infix_exp { Lt($3,$1) }
  | infix_exp { $1 }

infix_exp:
  | plus_minus_exp { $1 }
  | times_div_mod_exp { $1 }
  | and_exp { $1 }
  | or_exp { $1 }
  | app_exp { $1 }

plus_minus_exp:
  | plus_minus_exp PLUS app_exp { Plus($1,$3) }
  | plus_minus_exp MINUS app_exp { Minus($1,$3) }
  | app_exp PLUS app_exp { Plus($1,$3) }
  | app_exp MINUS app_exp { Minus($1,$3) }

times_div_mod_exp:
  | times_div_mod_exp TIMES app_exp { Times($1,$3) }
  | times_div_mod_exp DIV app_exp { Div($1,$3) }
  | times_div_mod_exp MOD app_exp { Mod($1,$3) }
  | app_exp TIMES app_exp { Times($1,$3) }
  | app_exp DIV app_exp { Div($1,$3) }
  | app_exp MOD app_exp { Mod($1,$3) }

and_exp:
  | and_exp AND app_exp { And($1,$3) }
  | app_exp AND app_exp { And($1,$3) }

or_exp:
  | or_exp OR app_exp { Or($1,$3) }
  | app_exp OR app_exp { Or($1,$3) }

app_exp:
  | app_exp atomic_exp { App($1,$2) }
  | atomic_exp { $1 }

atomic_exp:
  | VAR { Var($1) }
  | NUM { Num($1) }
  | TRUE { Bool(true) }
  | FALSE { Bool(false) }
  | NOT atomic_exp { Not($2) }
  | LPAREN exp RPAREN { $2 }

%%
