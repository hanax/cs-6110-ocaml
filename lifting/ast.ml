(* Abstract syntax trees and associated utilities. *)

open Printf
open Util

type id = string

(* The FL language. *)
type exp =
  | Var of id
  | Fun of id list * exp
  | Let of id list * exp * exp
  | Letrec of id list * exp * exp
  | App of exp * exp
  | Cond of exp * exp * exp

  (* Arithmetic expressions. *)
  | Num of int
  | Plus of exp * exp
  | Minus of exp * exp
  | Times of exp * exp
  | Div of exp * exp
  | Mod of exp * exp

  (* Boolean expressions. *)
  | And of exp * exp
  | Or of exp * exp
  | Not of exp
  | Eq of exp * exp
  | Leq of exp * exp
  | Lt of exp * exp
  | Bool of bool

(* Pretty-print an AST. *)
let rec to_string (e : exp) : string =
  match e with
    | Var x -> x
    | Fun (x, e) -> sprintf "fun %s -> %s" (String.concat " " x) (to_string e)
    | Let (x, e1, e2) -> sprintf "let %s = %s in\n%s" (String.concat " " x) (to_string e1) (to_string e2)
    | Letrec (x, e1, e2) -> sprintf "let rec %s = %s in\n%s" (String.concat " " x) (to_string e1) (to_string e2)
    | App (e1, e2) -> sprintf "(%s %s)" (to_string e1) (to_string e2)
    | Cond (b, e1, e2) -> sprintf "if %s then %s else %s" (to_string b) (to_string e1) (to_string e2)
(* arithmetic expressions *)
    | Num n -> string_of_int n
    | Plus (n1, n2) -> sprintf "(%s + %s)" (to_string n1) (to_string n2)
    | Minus (n1, n2) -> sprintf "(%s - %s)" (to_string n1) (to_string n2)
    | Times (n1, n2) -> sprintf "(%s * %s)" (to_string n1) (to_string n2)
    | Div (n1, n2) -> sprintf "(%s / %s)" (to_string n1) (to_string n2)
    | Mod (n1, n2) -> sprintf "(%s mod %s)" (to_string n1) (to_string n2)
(* boolean expressions *)
    | And (b1, b2) -> sprintf "(%s & %s)" (to_string b1) (to_string b2)
    | Or (b1, b2) -> sprintf "(%s | %s)" (to_string b1) (to_string b2)
    | Not b -> sprintf "~(%s)" (to_string b)
    | Eq (b1, b2) -> sprintf "%s = %s" (to_string b1) (to_string b2)
    | Leq (b1, b2) -> sprintf "%s <= %s" (to_string b1) (to_string b2)
    | Lt (b1, b2) -> sprintf "%s < %s" (to_string b1) (to_string b2)
    | Bool b -> string_of_bool b

(* Get the free variables of an expression. *)
let fv (e : exp) : id HashSet.t =
  let h = HashSet.make() in
  let rec fv (bv : id list) (e : exp) : unit =
    match e with
    | Var x -> if List.mem x bv then () else HashSet.add h x
    | Fun (x, e) -> fv (x @ bv) e
    | Let (f :: t, e1, e2) -> fv (t @ bv) e1; fv (f :: bv) e2
    | Letrec (f :: t, e1, e2) -> fv (f :: t @ bv) e1; fv (f :: bv) e2
    | Let _ -> failwith "System error"
    | Letrec _ -> failwith "System error"
    | App (e1, e2) -> fv bv e1; fv bv e2
    | Cond (b, e1, e2) -> fv bv b; fv bv e1; fv bv e2
    | (Num _ | Bool _) -> ()
    | (Plus (e1, e2) | Minus (e1, e2) | Times (e1, e2) | Div (e1, e2) | Mod (e1, e2)
        | And (e1, e2) | Or (e1, e2) | Eq (e1, e2) | Leq (e1, e2) | Lt (e1, e2))
          -> fv bv e1; fv bv e2
    | Not b -> fv bv b in
  fv [] e; h

(* Get all variables of an expression. *)
let allv (e : exp) : id HashSet.t =
  let h = HashSet.make() in
  let rec allv (e : exp) : unit =
    match e with
    | Var x -> HashSet.add h x
    | Fun (x, e) -> List.iter (HashSet.add h) x; allv e
    | (Let (x, e1, e2) | Letrec (x, e1, e2)) -> List.iter (HashSet.add h) x; allv e1; allv e2
    | Cond (b, e1, e2) -> allv b; allv e1; allv e2
    | (Num _ | Bool _) -> ()
    | (App (e1, e2) | Plus (e1, e2) | Minus (e1, e2) | Times (e1, e2) | Div (e1, e2) | Mod (e1, e2)
        | And (e1, e2) | Or (e1, e2) | Eq (e1, e2) | Leq (e1, e2) | Lt (e1, e2))
          -> allv e1; allv e2
    | Not b -> allv b in
  allv e; h

(* Substitute v for x in e, avoiding capture. *)
let subst (v : exp) (x : id) (e : exp) : exp =
let fresh = Fresh.make (allv e) in
let fvv = fv v in
let rec subst (v : exp) (x : id) (e : exp) : exp =
  match e with
  | Var y -> if x = y then v else Var y
  | Fun (y :: t, e1) ->
      if x = y then e else
      (* alpha-convert if y captures a free var in v *)
      let e0 = Fun (t, e1) in
      let (z, e0) =
        if HashSet.mem fvv y
        then let z = Fresh.next fresh in
          (z, subst (Var z) y e0)
        else (y, e0) in
      (match subst v x e0 with
      | Fun (t, e1') -> Fun (z :: t, e1')
      | _ -> failwith "System error")
  | Fun ([], e1) -> Fun ([], subst v x e1)
  | App (e1, e2) -> App (subst v x e1, subst v x e2)
  | Let (f :: t, e1, e2) ->
      (match (subst v x (Fun ([f], e2)), subst v x (Fun (t, e1))) with
      | (Fun([f], e2'), Fun (t, e1')) -> Let (f :: t, e1', e2')
      | _ -> failwith "System error")
  | Let _ -> failwith "System error"
  | Letrec (f :: t, e1, e2) ->
      (* same as let, except f is in scope in e1 *)
      (match subst v x (Fun ([f], App (Fun (t, e1), e2))) with
      | (Fun ([f], App (Fun (t, e1'), e2'))) -> Letrec (f :: t, e1', e2')
      | _ -> failwith "System error")
  | Letrec _ -> failwith "System error"
  | Cond (b, e1, e2) -> Cond (subst v x b, subst v x e1, subst v x e2)
(* arithmetic expressions *)
    | Num n -> e
    | Plus (n1, n2) -> Plus (subst v x n1, subst v x n2)
    | Minus (n1, n2) -> Minus (subst v x n1, subst v x n2)
    | Times (n1, n2) -> Times (subst v x n1, subst v x n2)
    | Div (n1, n2) -> Div (subst v x n1, subst v x n2)
    | Mod (n1, n2) -> Mod (subst v x n1, subst v x n2)
(* boolean expressions *)
    | And (b1, b2) -> And (subst v x b1, subst v x b2)
    | Or (b1, b2) -> Or (subst v x b1, subst v x b2)
    | Not b -> Not (subst v x b)
    | Eq (b1, b2) -> Eq (subst v x b1, subst v x b2)
    | Leq (b1, b2) -> Leq (subst v x b1, subst v x b2)
    | Lt (b1, b2) -> Lt (subst v x b1, subst v x b2)
    | Bool b -> e in
  subst v x e
