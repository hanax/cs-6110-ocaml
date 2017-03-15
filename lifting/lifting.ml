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
  let fr = Fresh.make (allv e)
  in let rec helper (ee : exp) (ss : state) : exp * state =
    match ee with
    | Var _ -> (ee, ss)
    | Fun (x, ee) -> let (eee, sss) = helper ee ss
      in let fv_l = HashSet.values (fv (Fun (x, eee))) in let f = Fresh.next fr
      in let rec app_l ff f_l = match f_l with 
        | [] -> ff
        | h :: l -> app_l (App (ff, Var h)) l
      in (app_l (Var f) fv_l, update sss f (Closure (Fun (List.append fv_l x, eee), make ())))
    | Let ([i], ee1, ee2) -> helper (App (Fun ([i], ee2), ee1)) ss
    | Let (h :: l, ee1, ee2) -> helper (Let ([h], Fun (l, ee1), ee2)) ss 
    | Let _ -> failwith "wrong format" 
    | Letrec _ -> failwith "letrec not implemented" 
    | App (e1, e2) -> let (ee1, ss1) = helper e1 ss 
      in let (ee2, ss2) = helper e2 ss1 
      in (App (ee1, ee2), ss2)
    | Cond (b, e1, e2) -> let (bb, ss1) = helper b ss 
      in let (ee1, ss2) = helper e1 ss1 
      in let (ee2, ss3) = helper e2 ss2 
      in (Cond (bb, ee1, ee2), ss3)
    | Num _ -> (ee, ss)
    | Plus (n1, n2) -> let (nn1, ss1) = helper n1 ss 
      in let (nn2, ss2) = helper n2 ss1 
      in (Plus (nn1, nn2), ss2)
    | Minus (n1, n2) -> let (nn1, ss1) = helper n1 ss 
      in let (nn2, ss2) = helper n2 ss1 
      in (Minus (nn1, nn2), ss2)
    | Times (n1, n2) -> let (nn1, ss1) = helper n1 ss 
      in let (nn2, ss2) = helper n2 ss1 
      in (Times (nn1, nn2), ss2)
    | Div (n1, n2) -> let (nn1, ss1) = helper n1 ss 
      in let (nn2, ss2) = helper n2 ss1 
      in (Div (nn1, nn2), ss2)
    | Mod (n1, n2) -> let (nn1, ss1) = helper n1 ss 
      in let (nn2, ss2) = helper n2 ss1 
      in (Mod (nn1, nn2), ss2)
    | And (b1, b2) -> let (bb1, ss1) = helper b1 ss 
      in let (bb2, ss2) = helper b2 ss1 
      in (And (bb1, bb2), ss2)
    | Or (b1, b2) -> let (bb1, ss1) = helper b1 ss 
      in let (bb2, ss2) = helper b2 ss1 
      in (Or (bb1, bb2), ss2)
    | Not b -> let (bb, ss1) = helper b ss 
      in (Not bb, ss1)
    | Eq (b1, b2) -> let (bb1, ss1) = helper b1 ss 
      in let (bb2, ss2) = helper b2 ss1 
      in (Eq (bb1, bb2), ss2)
    | Leq (b1, b2) -> let (bb1, ss1) = helper b1 ss 
      in let (bb2, ss2) = helper b2 ss1 
      in (Leq (bb1, bb2), ss2)
    | Lt (b1, b2) -> let (bb1, ss1) = helper b1 ss 
      in let (bb2, ss2) = helper b2 ss1 
      in (Lt (bb1, bb2), ss2)
    | Bool _ -> (ee, ss)
  in helper e s

(* Convert a source FL expression into a complete, self-contained expression
   in the target version of FL. This function should call `convert` to get the
   new expression and the resulting function bindings. It should then turn all
   the bindings into `let` expressions to compose the complete program. *)
let lift (e : exp) : exp =
  let rec helper (ee : exp) (s : (id * value) list) : exp =
    match s with
    | (i, Closure (eee, _)) :: l -> helper (Let ([i], eee, ee)) l
    | [] -> ee
    | _ -> failwith "wrong format"
  in let (ee, s) = convert e (make ()) in helper ee (bindings s)
