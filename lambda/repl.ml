(* The read-eval-print loop. *)

open Util
open Ast
open Lambda

(* Parse an input expression. *)
let parse (s : string) : expr_s =
  Parser.parse Lexer.token (Lexing.from_string s)

(* A wrapper for evaluation that prints out the expression being evaluated,
 * pauses for user input, performs a reduction, and then prints out the
 * result. *)
let rec cbv (e : expr) : expr =
  if is_value e then
    (print_string "Result: "; print_endline (to_string e); e)
  else
    (print_endline (to_string e); cbv (cbv_step e))

(* Read lines from the console, appending them to s, until the user enters a
 * blank line. *)
let read_console() : string =
  let rec read_lines (s : string) : string =
    let input = read_line() in
    if input = "" then s
    else read_lines (s ^ input ^ " ")
  in read_lines ""

(* Main read-eval-print loop. *)
let rec repl () : unit =
  print_string "This program computes the translation and the step by step evaluation of an expression. Type in an expression, then type <Enter> twice.\n? ";
  (try
    let input = read_console() in
    let expr_s = parse input in
    let expr = translate expr_s in
    ignore (cbv expr);
    print_endline ""
  with Failure s -> print_endline ("Error: " ^ s)
  | Parsing.Parse_error -> print_endline "Parse Error");
  repl ()

let _ = repl()
