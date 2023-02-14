(* ****** ****** *)
(*
use "./../assign03.sml";
use "./../assign03-lib.sml";
*)
use "../../../mysmlib/mysmlib-ind.sml";
(* ****** ****** *)

(*
HX-2023-02-10: 20 points
Given a list of integers xs,
please implement a function that find
the longest ascending subsequences of [xs].
If there are more than one such sequences,
the left most one should be returned.

fun list_longest_ascend(xs: int list): int list
*)
fun list_longest_ascend(xs : int list) : int list =
    let
        fun longest_head(xs : int list) : int list =
            case xs of
                [] => []
             | [x] => [x]
             | x1 :: x2 :: xs => if x1 <= x2 then
                                    x1 :: longest_head(x2 :: xs)
                                 else
                                    [x1]
    in
        case xs of
            [] => []
        | x :: xs => 
    end

(* fun list_longest_ascend(xs : int list) : int list =
    let
        fun count_ascend(xs : int list , curr : int, len : int, ascend : int list) : int * int list =
            case xs of
                [] => (len,ascend)
            | x :: xs => if x >= curr then
                            count_ascend(xs,x,len+1, x :: ascend)
                        else
                            count_ascend(xs,curr,len,ascend)

        fun help (xs : int list, longest : int, longlst : int list) : int list =
            case xs of
                [] => longlst
            | x :: xs => let
                            val(l,a) = count_ascend(xs,x,1,[x])
                         in
                            if l > longest then
                                help(xs,l,a)
                            else
                                help(xs,longest,longlst)
                         end
    in
        list_reverse(help(xs,0,[]))
    end *)



(* ****** ****** *)

(* end of [CS320-2023-Spring-assign03-04.sml] *)
