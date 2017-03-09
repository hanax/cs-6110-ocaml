(* An interpreter for the FL AST. *)

open Ast
open State

(* Evaluate an expression in an environment. *)
let rec eval (e : exp) (s : state) : value =
  match e with
  | Var x ->
     lookup s x
  | Cond (b, c1, c2) ->
     (match eval b s with
      | Boolean true -> eval c1 s
      | Boolean false -> eval c2 s
      | _ -> failwith "Non-boolean used in conditional")
  | Fun ([], e) -> eval e s
  | Fun _ -> Closure (e, s)
  | Let (f :: t, e1, e2) -> eval (App (Fun ([f], e2), Fun (t, e1))) s
  | Let _ -> failwith "System error"
  | Letrec (f :: t, e1, e2) ->
     begin
       match t,e1 with
       | [],Num _
       | [],Bool _ ->
          eval (Let ([f], e1,e2)) s
       | [],Fun _
       | _::_, _ ->
          let a = eval (Fun (t, e1)) (update s f Error) in
          let s' = rec_update a f in
          let s'' = update s f (lookup s' f) in
          eval e2 s''
       | _ ->
          failwith "System error"
     end
  | Letrec _ -> failwith "System error"
  | App (e1, e2) ->
     (match eval e1 s with
      | Closure (Fun (x :: t, e), c) ->
         let v = eval e2 s in eval (Fun (t, e)) (update c x v)
      | _ -> failwith "Runtime type error - function expected")

  (* Arithmetic expressions. *)
  | Num n -> Number n
  | (Plus (a1, a2) | Minus (a1, a2) | Times (a1, a2) | Div (a1, a2) | Mod (a1, a2)) ->
     (match (e, eval a1 s, eval a2 s) with
      | (Plus _, Number n1, Number n2) -> Number (n1 + n2)
      | (Minus _, Number n1, Number n2) -> Number (n1 - n2)
      | (Times _, Number n1, Number n2) -> Number (n1 * n2)
      | (Div _, Number n1, Number n2) -> Number (n1 / n2)
      | (Mod _, Number n1, Number n2) -> Number (n1 mod n2)
      | _ -> failwith "Runtime type error - number expected")

  (* Boolean expressions. *)
  | Bool b -> Boolean b
  | (Eq (a1, a2) | Leq (a1, a2) | Lt (a1, a2)) ->
     (match (e, eval a1 s, eval a2 s) with
      | (Eq _, Number n1, Number n2) -> Boolean (n1 = n2)
      | (Eq _, Boolean b1, Boolean b2) -> Boolean (b1 = b2)
      | (Leq _, Number n1, Number n2) -> Boolean (n1 <= n2)
      | (Lt _, Number n1, Number n2) -> Boolean (n1 < n2)
      | _ -> failwith "Runtime type error - comparison")
  | (And (a1, a2) | Or (a1, a2)) ->
     (match (e, eval a1 s, eval a2 s) with
      | (And _, Boolean t1, Boolean t2) -> Boolean (t1 && t2)
      | (Or _, Boolean t1, Boolean t2) -> Boolean (t1 || t2)
      | _ -> failwith "Runtime type error - boolean expected")
  | Not b ->
     (match (eval b s) with
      | Boolean t -> Boolean (not t)
      | _ -> failwith "Runtime type error - boolean expected")
