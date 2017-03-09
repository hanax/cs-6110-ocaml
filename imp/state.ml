(* A state is a finite map from variables to integers. *)
type state = (string, int) Hashtbl.t

(* Make a new empty state. *)
let make () = Hashtbl.create 11

(* Look up a variable by name and return the value. *)
(* Raises an exception if there is no binding for the variable. *)
let lookup (s : state) (var : string) : int =
  try Hashtbl.find s var
  with Not_found -> failwith ("Uninitialized variable " ^ var)

(* Rebind `var` to `value` in `s`. *)
let rebind (s : state) (var : string) (value : int) : state =
  Hashtbl.remove s var; Hashtbl.add s var value; s
