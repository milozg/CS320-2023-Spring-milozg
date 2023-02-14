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
                                    list_size_compare(x1 :: longest_head(x2 :: xs), longest_head(x1 :: xs))
                                 else
                                    longest_head(x1 :: xs)

        fun get_longest(xs : int list, long : int list) : int list =
            case xs of
                [] => long
             | x :: xs => let
                            val ys = longest_head(x :: xs)
                          in
                            case list_size(ys) > list_size(long) of
                                true => get_longest(xs, ys)
                             |false => get_longest(xs, long)
                          end
    in
        get_longest(xs,[])
    end

(* ****** ****** *)

(* end of [CS320-2023-Spring-assign03-04.sml] *)
