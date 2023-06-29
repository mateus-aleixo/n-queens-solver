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

(* Test case for n = 4 *)
let test_nqueens_4 () =
  let test_solutions =
    [
      (* Solution 1 *)
      [| ".Q.."; "...Q"; "Q..."; "..Q." |];
      (* Solution 2 *)
      [| "..Q."; "Q..."; "...Q"; ".Q.." |];
    ]
  in
  let solutions = solve_nqueens 4 in
  let passed = solutions = test_solutions in
  if passed then print_endline "Test case for n = 4 passed."
  else print_endline "Test case for n = 4 failed."

(* Test case for n = 1 *)
let test_nqueens_1 () =
  let test_solutions = [ (* Solution 1 *) [| "Q" |] ] in
  let solutions = solve_nqueens 1 in
  let passed = solutions = test_solutions in
  if passed then print_endline "Test case for n = 1 passed."
  else print_endline "Test case for n = 1 failed."

(* Run the tests *)
let run_tests () =
  test_nqueens_4 ();
  test_nqueens_1 ()

(* Execute the tests *)
let () = run_tests ()
