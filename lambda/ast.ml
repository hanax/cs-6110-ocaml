(* Abstract syntax tree for the lambda-calculus. *)

open Printf
open Util

type id = string

(* Plain source language. *)
type expr =
  | Var of id
  | Fun of id * expr
  | App of expr * expr

(* Source language with syntactic sugar. *)
type expr_s =
  | Var_s of id
  | Fun_s of id list * expr_s
  | Let_s of id * expr_s * expr_s
  | App_s of expr_s * expr_s

let precedence = function
  | Some (Var _) -> 7
  | Some (App _) -> 5
  | Some (Fun _) -> 1
  | None -> 0

type assoc = LEFT | RIGHT | PREFIX | SUFFIX | NONASSOC

let assoc = function
  | Some (App _) -> LEFT
  | Some (Fun _) -> PREFIX
  | Some (Var _) -> NONASSOC
  | None -> NONASSOC

(* Create a printable form of an expression. *)
let rec to_string (e : expr) : string =
  (* parenthesize based on associativity and precedence *)
  let rec protect e1 e e2 : string =
    let (p1, p, p2) = (precedence e1, precedence (Some e), precedence e2) in
    let (a1, a, a2) = (assoc e1, assoc (Some e), assoc e2) in
    let s = match e with
      | Var x -> x
      | Fun (x, e) -> sprintf "fun %s -> %s" x (protect None e e2)
      | App (e3, e4) -> sprintf "%s %s" (protect e1 e3 (Some e)) (protect (Some e) e4 e2) in
    if (p < p1 && a <> PREFIX)
      || (p = p1 && a1 = LEFT)
      || (p < p2 && a <> SUFFIX)
      || (p = p2 && a2 = RIGHT)
    then sprintf "(%s)" s else s in
    protect None e None

(* Get the free variables of an expression. *)
let fv (s : expr) : id HashSet.t =
  let h = HashSet.make() in
  let rec fv (bv : id list) (e : expr) : unit =
    match e with
    | Var x -> if List.mem x bv then () else HashSet.add h x
    | Fun (x, e) -> fv (x :: bv) e
    | App (e1, e2) -> fv bv e1; fv bv e2
  in fv [] s; h

(* Get a fresh variable not occurring in an expression. *)
let fresh (s : expr) : id =
  let h = fv s in
  let ls = LexStream.make() in
  let rec f() : id =
    let v = LexStream.next ls in
    if HashSet.mem h v then f() else v in
  f()
