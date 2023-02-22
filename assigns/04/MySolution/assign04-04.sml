(* ****** ****** *)
use
"./../../../mysmlib/mysmlib-cls.sml";
(* ****** ****** *)

(*
//
HX-2023-02-16: 30 points
//
Here is an implementation of the famous 8-queen puzzle:
https://ats-lang.sourceforge.net/DOCUMENT/INT2PROGINATS/HTML/x631.html
//
Please give a NON-RECURSIVE implementation that solves the 8-queen puzzle.
//
type board_t =
int * int * int * int * int * int * int * int
//
fun
queen8_puzzle_solve(): board_t list =
(*
returns a list of boards consisting of all the solutions to the puzzle.
*)
//
*)

type board_t =
int * int * int * int * int * int * int * int

(* FROM THE TEST FILE *)
val
board_foreach =
fn
( bd: board_t , work: int -> unit) =>
    let
        val (x0, x1, x2, x3, x4, x5, x6, x7) = bd
    in
      work(x0); work(x1); work(x2); work(x3);
      work(x4); work(x5); work(x6); work(x7); ()
    end

val
board_get =
fn
(b : board_t, i : int) =>
    foreach_to_get_at(board_foreach)(b,i)

val
safety_test1 =
fn
(i0 : int, j0 : int, i : int, j : int) =>
    (j0 <> j) andalso abs_int(i0 - i) <> abs_int(j0 - j)

val
safety_test2 =
fn
(i0 : int, j0 : int, b : board_t, i : int) =>
    if i >= 0 then
        int1_forall(i, fn(x) => safety_test1(i0,j0,x,board_get(b,x)))
    else
        true



(* ****** ****** *)

(* end of [CS320-2023-Spring-assign04-04.sml] *)
