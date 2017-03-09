(* Some handy utilities. *)

(* Apply a function "inside" an option monad. *)
let option_map (f : 'a -> 'b) (x : 'a option) : 'b option =
  match x with
  | Some a -> Some (f a)
  | None -> None

(* A hash-based set data structure that behaves like Java's HashSet. *)
module type HashSet = sig
  type 'a t
  val make : unit -> 'a t  (* Create a new set. *)
  val add : 'a t -> 'a -> unit  (* Add something to a set. *)
  val remove : 'a t -> 'a -> unit  (* Remove something from a set. *)
  val mem : 'a t -> 'a -> bool  (* Check whether something exists in a set. *)
  val size : 'a t -> int  (* Get the size of a set. *)
end

module HashSet : HashSet = struct
  type 'a t = ('a, 'a) Hashtbl.t
  let make() : 'a t = Hashtbl.create 16
  let add (h : 'a t) (x : 'a) = Hashtbl.add h x x
  let remove (h : 'a t) (x : 'a) =
    while Hashtbl.mem h x do
      Hashtbl.remove h x
    done
  let mem (h : 'a t) (x : 'a) = Hashtbl.mem h x
  let size (h : 'a t) : int = Hashtbl.length h
end

(* A stream of strings in length-lexicographic order. This is useful to create
 * fresh variable names. *)
module type LexStream = sig
  type t
  val make : unit -> t
  val next : t -> string
end

module LexStream : LexStream = struct
  type t = int list ref

  let rec inc (s : int list) : int list =
    match s with
      | [] -> [Char.code 'a']
      | x :: t ->
          if x < Char.code 'z' then (x + 1) :: t
          else Char.code 'a' :: inc t

  let make() : t = ref [Char.code 'a']

  let next (h : t) : string =
    let l = !h in
    h := inc l;
    String.concat "" (List.map (String.make 1) (List.map Char.chr (List.rev l)))
end

