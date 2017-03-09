(* The lambda-lifting transformation. *)

open Util
open Ast
open State

(* Check whether an expression is in the "target language", i.e., it is
   lambda-free. You can use this function to test whether you have
   successfully converted an expression. *)
let rec is_target_exp (e : exp) : bool =
  match e with
    | Var _ -> true
    | Fun  _ -> false
    | Let _ -> false
    | Letrec _ -> false
    | App (e1, e2) -> is_target_exp e1 && is_target_exp e2
    | Cond (b, e1, e2) -> is_target_exp b && is_target_exp e1 && is_target_exp e2
    | Num _ -> true
    | Plus (n1, n2) -> is_target_exp n1 && is_target_exp n2
    | Minus (n1, n2) -> is_target_exp n1 && is_target_exp n2
    | Times (n1, n2) -> is_target_exp n1 && is_target_exp n2
    | Div (n1, n2) -> is_target_exp n1 && is_target_exp n2
    | Mod (n1, n2) -> is_target_exp n1 && is_target_exp n2
    | And (b1, b2) -> is_target_exp b1 && is_target_exp b2
    | Or (b1, b2) -> is_target_exp b1 && is_target_exp b2
    | Not b -> is_target_exp b
    | Eq (b1, b2) -> is_target_exp b1 && is_target_exp b2
    | Leq (b1, b2) -> is_target_exp b1 && is_target_exp b2
    | Lt (b1, b2) -> is_target_exp b1 && is_target_exp b2
    | Bool _ -> true

let rec is_target_fun (e : exp) : bool =
  match e with
    | Fun (_, (Fun _ as e1)) -> is_target_fun e1
    | Fun (_, e1) -> is_target_exp e1
    | _ -> false

let rec is_target_prog (e : exp) : bool =
  match e with
    | Let(_, e1, p2) -> is_target_fun e1 && is_target_prog p2
    | Letrec(_, e1, p2) -> is_target_fun e1 && is_target_prog p2
    | _ -> is_target_exp e


(* Convert an expression from the source FL to the restricted FL target
   language. e is the expression to convert, and s is a store that contains
   the functions converted *so far*. You will want to add new bindings to s
   and return the expanded mapping along with the converted expression. *)
let convert (e : exp) (s : state) : exp * state =
  failwith "Implement me!"
  (* Remember: the `Letrec` case is a karma problem (worth zero points). If
     you are not attempting that part, you can just use "failwith" to bail out
     if you encounter a `Letrec` in the AST. *)

(* Convert a source FL expression into a complete, self-contained expression
   in the target version of FL. This function should call `convert` to get the
   new expression and the resulting function bindings. It should then turn all
   the bindings into `let` expressions to compose the complete program. *)
let lift (e : exp) : exp =
  failwith "Implement me!"
