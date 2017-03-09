(* Top-level read-eval-print loop. *)

exception Quit

(* Current parsed program. *)
let program : Ast.exp option ref = ref None

(* Command handlers. *)

let load (file : string) : unit =
  let ch =
    try open_in file
    with Sys_error s -> failwith ("Cannot open file: " ^ s) in
  let parse : Ast.exp =
      let lexbuf = Lexing.from_channel ch in
      try
        Parser.main Lexer.token lexbuf
      with _ ->
        begin
          close_in ch;
          failwith ("Parsing error at character " ^ string_of_int (Lexing.lexeme_end lexbuf))
        end in
  program := Some parse;
  close_in ch

let list() : unit =
  match !program with
    | Some exp -> print_endline (Ast.to_string exp)
    | None -> failwith "No program loaded"

let run() : unit =
  match !program with
    | Some exp ->
        let value = Eval.eval exp (State.make()) in
        print_endline (State.to_string value)
    | None -> failwith "No program loaded"

let convert() : unit =
  match !program with
    | Some exp ->
        let (e, s) = Lifting.convert exp (State.make()) in
        let value = Eval.eval e s in
        print_endline (State.to_string value)
    | None -> failwith "No program loaded"

let lift() : unit =
  match !program with
    | Some exp ->
      let p = Lifting.lift exp in
      program := Some p;
      if not (Lifting.is_target_prog p) then
        failwith "Result of lift is not a valid target language program"
    | None -> failwith "No program loaded"

let help() : unit =
  print_endline "Available commands are:";
  print_endline "load <file>, list, lift, run, convert, help, quit"

let quit() : unit =
  print_endline "bye";
  raise Quit

(* main read-eval-print loop *)
let rec repl() : unit =
  print_string ">> ";
  (try
    let input = Str.split (Str.regexp "[ \t]+") (read_line()) in
    match input with
      | [] -> ()
      | cmd :: args ->
        match (cmd, args) with
          | ("load", [filename]) -> load filename
          | ("list", []) -> list()
          | ("lift", []) -> lift()
          | ("run", []) -> run()
          | ("convert", []) -> convert()
          | ("quit", []) -> quit()
          | _ -> help()
  with Failure s -> print_endline s);
  repl()

let _ =
  print_endline "FL version 2017.0";
  try repl()
  with Quit -> ()
