(* ****** ****** *)
use "./../../mysmlib/mysmlib-cls.sml";
(* ****** ****** *)
(*
HX-2023-03-01: midterm1-01: 10 points
*)
(* ****** ****** *)
(*
Given a list xs, list_pairing(xs) returns
a list of pairs and an option; the 1st pair
consists of the first and last elements in xs,
and the 2nd pair consists of the second and the
second last elements in xs, and so on and so forth;
and the option is NONE if |xs| is even, and it is
SOME(xm) if |xs| is odd and xm is the middle element
in xs.
//
For instance, we have:
//
list_pairing([]) = ([], NONE)
list_pairing([1]) = ([], SOME(1))
list_pairing([1,2]) = ([(1,2)], NONE)
list_pairing([1,2,3]) = ([(1,3)], SOME(2))
list_pairing([1,2,3,4]) = ([(1,4),(2,3)], NONE)
//
*)
(* ****** ****** *)

fun
list_pairing
(xs: 'a list): ('a * 'a) list * 'a option =
    let
        val len = list_length(xs)
        val opt = if len mod 2 = 0 then NONE else SOME(list_get_at(xs,(len div 2) + 1))
        fun half(xs : 'a list, i : int, n : int, acc : 'a list) : 'a list =
            case i >=n of
                true => acc
            | false => case xs of
                        [] => acc
                        |x :: xs => half(xs, i+1, n, x :: acc)

        val ys = half(xs,0,(len div 2)-1,[])
        val half_xs = list_reverse(ys)
    in
        (list_zip2(half_xs,ys),opt)
    end




(* ****** ****** *)

(* end of [CS320-2023-Spring-midterm1-list_pairing.sml] *)
