(* ****** ****** *)

use "./../../mysmlib//mysmlib-cls.sml";

(* ****** ****** *)

(*
//
// HX-2023-04-20: 20 points
//
The mytree datatype is defined as follows.
Each node in mytree contains a stored element
plus a list of children, where the list can be
empty.
//
Please implement a function mytree_dfs_streamize
that enumerates a given mytree in a depth-first manner.
//
*)
(* ****** ****** *)

datatype 'a mytree =
  mytree_node of 'a * ('a mytree list)

(* ****** ****** *)


fun mytree_dfs_streamize(t0: 'a mytree): 'a stream =
    let
        fun help(t0: 'a mytree) : 'a * ('a mytree list) =
            case t0 of
                mytree_node(x,ts) => (x,ts)

        val (x,ts) = help(t0)
    in
        case ts of
            [] => stream_cons(x,stream_nil)
        | t :: ts => stream_cons(x,)
    end


(* ****** ****** *)

(* end of [CS320-2023-Spring-midterm2-02.sml] *)
