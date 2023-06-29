# N-Queens Problem Solver

This is an OCaml program that solves the N-Queens problem. Given a value of ```N```, the program finds all possible solutions to the problem of placing N chess queens on an ```N×N``` chessboard such that no two queens threaten each other.

Each solution contains a distinct board configuration of the n-queens' placement, where ```'Q'``` and ```'.'``` both indicate a queen and an empty space, respectively.

## Usage

1. Make sure you have OCaml and Dune installed on your system.

2. Clone the repository or download the source code.

3. Navigate to the project directory.

4. Build the project using Dune: ```dune build```

5. Run the compiled program: ```dune exec nqueens```

6.  Enter the value of N when prompted

7.  The program will display all the valid solutions for the N-Queens problem on an N×N chessboard.

## How It Works

The program uses a backtracking algorithm to find all possible solutions. It places queens on the chessboard row by row, making sure that no two queens threaten each other. The algorithm employs recursive backtracking and maintains flags to track the availability of columns and diagonals for queen placement.

## Example Output

Here's an example output for N = 4:

```
---------------
| Q = ♛ Queen |
---------------

-------------
|.Q..| |..Q.| 
|...Q| |Q...| 
|Q...| |...Q| 
|..Q.| |.Q..| 
-------------
```

This represents the valid solutions for the N-Queens problem on a 4×4 chessboard.

## Constrains

```1 <= N <= 9```
