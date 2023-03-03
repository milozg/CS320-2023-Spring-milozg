(* ****** ****** *)
use "./../../mysmlib/mysmlib-cls.sml";
(* ****** ****** *)
(*
HX-2023-03-02: midterm-06: 20 points
//
Given a list of integers xs, list_grouping(xs)
returns a list of pairs (n, x) where n indicates
the number of times x occurs in xs; for each x in
xs, there must be a pair (n, x) for some n in the
returned list.
//
For instance,
list_grouping([1,2]) = [[1,1], [1,2]]
list_grouping([1,2,2,2,1]) = [[2,1], [3,2]]
list_grouping([1,2,1,2,3]) = [[2,1], [2,2], [1,3]]
//
In order to receive full credit, your implementation
should be able to handle a list containing 1M elements
in less than 10 seconds (mine can do it in less than
two seconds)
//
*)
(* ****** ****** *)
fun update_pairs(pairs : (int * int) list, n : int) : (int * int) list =
    let
        val stand_in = pairs
    in
        case pairs of
            [] => (1,n) :: stand_in
        | (i,x) :: xs =>  case x = n of
                            true => (i + 1, x) :: xs
                         |false => (i,x) :: update_pairs(xs,n)
    end

fun
list_grouping(xs: int list): (int * int) list =
    let
        fun help(xs : int list, pairs : (int * int) list) : (int * int) list =
            case xs of
                [] => pairs
            |x :: xs => let
                            val new_pairs = update_pairs(pairs,x)
                        in
                            help(xs,new_pairs)
                        end
    in
        help(xs,[])
    end


(* ****** ****** *)

(*
Some testing code:
val N = 1000
val nxs = list_grouping(int1_map_list(N, fn i => N-i))
*)
(* ****** ****** *)

(*
Some testing code:
Your implementation needs to be efficient to pass the
following test:
val N = 1000000
val nxs = list_grouping(int1_map_list(N, fn i => N-i))
*)

(* ****** ****** *)

(* end of [CS320-2023-Spring-midterm1-list_grouping.sml] *)
