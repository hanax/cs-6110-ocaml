(* An interpreter for the lambda-calculus. *)

open Printf
open Util
open Ast

(* Check whether an expression is a value. A value is a fully evaluated
 * expression. *)
let is_value (e : expr) : bool =
  match e with
  | Fun _ -> true
  | Var x -> failwith ("Unbound variable " ^ x)
  | _ -> false

(* Check whether a term is closed. *)
let is_closed (e : expr) : bool = HashSet.size (fv e) = 0

(* Translate from an expression of type `expr_s`, with syntactic sugar, to
   a sugar-free expression of type `expr`. Functions with zero arguments are
   not allowed; you can just throw an error if one is provided. *)
let rec translate (e : expr_s) : expr =
  let rec helper (ee : expr_s) : expr =
    match ee with
    | Var_s x -> Var x
    | Fun_s (h :: l, ee) -> Fun (h, helper (Fun_s (l, ee)))
    | Fun_s ([], ee) -> helper ee 
    | Let_s (x, e1, e2) -> App (Fun (x, helper e2), helper e1)
    | App_s (e1, e2) -> App (helper e1, helper e2)
  in helper e

(* Substitute `v` for `x` in `e`, avoiding capture. *)
let rec subst (e : expr) (v : expr) (x : id) : expr =
  let rec helper (ee : expr) : expr =
    match ee with
    | Var i -> if i = x then v else ee
    | Fun (i, ex) ->
      if (i = x || not (HashSet.mem (fv ex) x)) then Fun (i, ex)
      else if (HashSet.mem (fv v) i) then Fun (fresh (App (v, ee)), helper ee)
      else Fun (i, helper ex);
    | App (ex1, ex2) -> App (helper ex1, helper ex2)
  in helper e

(* Apply one call-by-value beta-reduction step to `e`. If `e` cannot be
 * reduced under CBV, the function can throw an error. *)
let rec cbv_step (e : expr) : expr =
  let rec helper (ee : expr) : expr =
    match ee with
    | Var i -> ee
    | Fun (i, ex) -> ee
    | App (Fun (ii, eex), ex2) -> subst eex (helper ex2) ii
    | App (Var i, _) -> failwith "cannot be reduced under CBV"
    | App (ex1, ex2) -> App (helper ex1, helper ex2)
  in helper e
