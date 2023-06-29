(lang dune 3.8)

(name nqueens)

(generate_opam_files true)

(source
 (github mateus-aleixo/n-queens-solver))

(authors "Mateus Aleixo")

(maintainers "Mateus Aleixo")

(license MIT)

(documentation https://url/to/documentation)

(package
 (name nqueens)
 (synopsis "Solve the N-Queens problem")
 (description "This is an OCaml program that solves the N-Queens problem. Given a value of N, the program finds all possible solutions to the problem of placing N chess queens on an N×N chessboard such that no two queens threaten each other.")
 (depends ocaml dune)
 (tags
  ("algorithms" "backtracking" "puzzle")))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project
