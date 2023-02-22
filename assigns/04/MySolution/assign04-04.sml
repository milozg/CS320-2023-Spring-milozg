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

val
board_set =
fn
(b : board_t, i : int, j : int) =>
let
    val (x0,x1,x2,x3,x4,x5,x6,x7) = b
in
    case i of
    0 => (j,x1,x2,x3,x4,x5,x6,x7)
   |1 => (x0,j,x2,x3,x4,x5,x6,x7)
   |2 => (x0,x1,j,x3,x4,x5,x6,x7)
   |3 => (x0,x1,x2,j,x4,x5,x6,x7)
   |4 => (x0,x1,x2,x3,j,x5,x6,x7)
   |5 => (x0,x1,x2,x3,x4,j,x6,x7)
   |6 => (x0,x1,x2,x3,x4,x5,j,x7)
   |7 => (x0,x1,x2,x3,x4,x5,x6,j)
   |_ => b
end

val
possible_cols_for_row =
fn
(b : board_t, i : int) =>
foreach_to_filter_list(int1_foreach)(8, fn(x) => safety_test2(i,x,b,i))

val
update_blist =
fn
(bs : board_t list, i : int) =>
    list_foldleft(bs, [], fn(r,b) => let
                                        val ps = possible_cols_for_row(b,i)
                                     in
                                        case ps of
                                            [] => r
                                            |_ => r @ list_map(ps, fn(x) => board_set(b,i,x))
                                     end)

fun
queen8_puzzle_solve(): board_t list =
let
    val start = [(~1,~1,~1,~1,~1,~1,~1,~1)]
    val bs = int1_foldleft(8,start, fn(r,i) => update_blist(r,i))
in
    bs
end
(* ****** ****** *)

(* end of [CS320-2023-Spring-assign04-04.sml] *)
