(* Solve the N-Queens problem *)
let solve_nqueens (n : int) : string array list =
  let res = ref [] in
  let rec solve_nqueens_helper (n_queens : string array) (flag_col : bool array)
      (flag_45 : bool array) (flag_135 : bool array) (row : int) : unit =
    (* Base case: All rows have been processed *)
    if row = n then res := n_queens :: !res
    else
      for col = 0 to n - 1 do
        (* Check if it's safe to place a queen at the current position *)
        if flag_col.(col) && flag_45.(row + col) && flag_135.(n - 1 + col - row)
        then (
          (* Place a queen at the current position *)
          flag_col.(col) <- false;
          flag_45.(row + col) <- false;
          flag_135.(n - 1 + col - row) <- false;
          let new_n_queens = Array.copy n_queens in
          new_n_queens.(row) <-
            String.make col '.' ^ "Q" ^ String.make (n - col - 1) '.';
          (* Recursively solve for the next row *)
          solve_nqueens_helper new_n_queens flag_col flag_45 flag_135 (row + 1);
          (* Backtrack by restoring the flags *)
          flag_col.(col) <- true;
          flag_45.(row + col) <- true;
          flag_135.(n - 1 + col - row) <- true)
      done
  in
  let n_queens = Array.make n "" in
  let flag_col = Array.make n true in
  let flag_45 = Array.make ((2 * n) - 1) true in
  let flag_135 = Array.make ((2 * n) - 1) true in
  (* Start solving from the first row *)
  solve_nqueens_helper n_queens flag_col flag_45 flag_135 0;
  (* Return the solutions in reverse order *)
  List.rev !res

(* Get the maximum number of solutions to be shown per row *)
let solutions_per_row (solutions : string array list) : int =
  let size = List.length solutions in
  let rec find_max_solutions_per_row (i : int) : int =
    if i > 0 && size mod i = 0 then i else find_max_solutions_per_row (i - 1)
  in
  find_max_solutions_per_row 9

(* Split a list at a given index *)
let split_list_at (lst : 'a list) (n : int) : 'a list * 'a list =
  let rec split (count : int) (acc : 'a list) = function
    | [] -> (List.rev acc, [])
    | hd :: tl ->
        if count = 0 then (List.rev acc, hd :: tl)
        else split (count - 1) (hd :: acc) tl
  in
  split n [] lst

(* Transpose the solutions *)
let transposed_solutions (solutions : string array list) : string array list =
  match solutions with
  | [] -> []
  | _ ->
      let num_rows = List.length solutions in
      let num_cols = Array.length (List.hd solutions) in
      let transposed =
        Array.make_matrix num_cols num_rows (List.hd solutions).(0)
      in
      List.iteri
        (fun i row ->
          Array.iteri (fun j elem -> transposed.(j).(i) <- elem) row)
        solutions;
      Array.to_list transposed

(* Print the legend *)
let print_legend () : unit =
  (* Unicode character for a chess queen *)
  let queen_icon = "\u{265B}" in
  print_endline "---------------";
  print_endline ("| Q = " ^ queen_icon ^ " Queen |");
  print_endline "---------------";
  (* Print an empty line for separation *)
  print_endline ""

(* Print solutions by row *)
let print_solutions_by_row (solutions : string array list) : unit =
  let n = Array.length (List.hd solutions) in
  let length = List.length solutions in
  let line = String.make (((n + 3) * length) - 1) '-' in
  let transposed = transposed_solutions solutions in
  (* Print the top border *)
  print_endline line;
  (* Print each row with the queens *)
  List.iter
    (fun arr ->
      Array.iter (fun row -> print_string ("|" ^ row ^ "| ")) arr;
      print_endline "")
    transposed;
  (* Print the bottom border *)
  print_endline line

(* Print every solution *)
let print_solutions (solutions : string array list) : unit =
  let num_rows = solutions_per_row solutions in
  let rec print_rows (solutions : string array list) : unit =
    match solutions with
    | [] -> ()
    | _ ->
        let rows, rest = split_list_at solutions num_rows in
        print_solutions_by_row rows;
        print_rows rest
  in
  print_rows solutions

(* Read a valid integer from the user *)
let rec read_valid_int (prompt : string) : int =
  print_string prompt;
  try
    let n = read_int () in
    (* Validate the input *)
    if n >= 1 && n <= 9 then n
    else (
      print_endline "Invalid input. Please enter a number between 1 and 9.";
      (* Retry *)
      read_valid_int prompt)
  with Failure _ ->
    print_endline "Invalid input. Please enter a valid number.";
    (* Retry *)
    read_valid_int prompt

(* Main entry point of the program *)
let rec main () : unit =
  let n = read_valid_int "Enter the value of N: " in
  let solutions = solve_nqueens n in
  match solutions with
  | [] ->
      print_endline "No solutions found.";
      (* Retry *)
      main ()
  | _ ->
      print_legend ();
      print_solutions solutions

(* Start the program *)
let () = main ()
