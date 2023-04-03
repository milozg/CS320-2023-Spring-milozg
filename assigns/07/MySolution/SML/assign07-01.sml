(* ****** ****** *)
use
"./../../../../mysmlib/mysmlib-cls.sml";
(* ****** ****** *)

(*
HX-2023-03-31: 10 points
Please implement the following function
that turns a list of streams into stream of
lists.
//
fun
stream_ziplst('a stream list): 'a list stream
//
If we use a list of streams to represent a
list of rows of a matrix, then the returned
stream consist of lists that are columns of the
matrix.
*)

(* ****** ****** *)

fun get_heads_and_tails(strs : 'a stream list) : ('a list * 'a stream list) option =
    let
        val help1 = fn(xs) => list_map(xs, fn(x) => stream_head(x))
        val help2 = fn(xs) => list_map(xs, fn(x) => stream_tail(x))
    in
        SOME(help1(strs),help2(strs)) handle Empty => NONE
    end

fun
stream_ziplst(strs : 'a stream list): 'a list stream = fn() =>
(
    case get_heads_and_tails(strs) of
        NONE => strcon_nil
    | SOME(heads,tails) => strcon_cons(heads, stream_ziplst(tails))
)

(* end of [CS320-2023-Spring-assign07-01.sml] *)
