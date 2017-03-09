(* Abstract syntax trees for IMP. *)

type aexp =
  | Var of string
  | Number of int
  | Plus of aexp * aexp
  | Minus of aexp * aexp
  | Times of aexp * aexp
  | Div of aexp * aexp
  | Mod of aexp * aexp
  | Input

type bexp =
  | Eq of aexp *aexp
  | Leq of aexp *aexp
  | Lt of aexp *aexp
  | Not of bexp
  | And of bexp * bexp
  | Or of bexp * bexp
  | True
  | False

type com =
  | While of bexp * com
  | For of aexp * com
  | Cond of bexp * com * com
  | Comp of com * com
  | Assg of string * aexp
  | Print of aexp
  | Skip
