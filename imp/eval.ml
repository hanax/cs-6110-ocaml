(* An interpreter for IMP based on its *large-step* semantics. This is the
 * only file you need to modify to complete Homework 2's programming
 * problem. *)

open Ast
open State

(* Evaluate an arithmetic expression in a state. *)
let rec eval_a (a : aexp) (s : state) : int =
  match a with
  | Var var -> lookup s var
  | Number var -> var
  | Plus (var1, var2) -> eval_a var1 s + eval_a var2 s
  | Minus (var1, var2) -> eval_a var1 s - eval_a var2 s
  | Times (var1, var2) -> eval_a var1 s * eval_a var2 s
  | Div (var1, var2) -> eval_a var1 s / eval_a var2 s
  | Mod (var1, var2) -> eval_a var1 s mod eval_a var2 s
  | Input -> try read_int() with int_of_string -> failwith ("not an int")
  (* failwith "Implement me!" *)

(* Evaluate a Boolean expression in a state. *)
let rec eval_b (b : bexp) (s : state) : bool =
  match b with
  | Eq (var1, var2) -> eval_a var1 s == eval_a var2 s
  | Leq (var1, var2) -> eval_a var1 s <= eval_a var2 s
  | Lt (var1, var2) -> eval_a var1 s < eval_a var2 s
  | Not var -> not(eval_b var s)
  | And (var1, var2) -> eval_b var1 s && eval_b var2 s
  | Or (var1, var2) -> eval_b var1 s || eval_b var2 s
  | True -> true
  | False -> false
  (* failwith "Implement me!" *)

(* Evaluate a command in a state. *)
let rec eval_c (c : com) (s : state) : state =
  match c with
  | Print a -> print_int (eval_a a s); print_newline(); s
  | While (b, cc) -> let bb = eval_b b s in
      if bb then eval_c c (eval_c cc s) else s
  | For (a, cc) -> let aa = eval_a a s in
      if aa > 0 then (eval_c cc s; eval_c (For (Number (aa - 1), cc)) s) else s
  | Cond (b, cc1, cc2) -> let bb = eval_b b s in 
      if bb then eval_c cc1 s else eval_c cc2 s
  | Comp (cc1, cc2) -> eval_c cc2 (eval_c cc1 s)
  | Assg (str, a) -> rebind s str (eval_a a s); s
  | Skip -> s
  (* failwith "Implement me!" *)
