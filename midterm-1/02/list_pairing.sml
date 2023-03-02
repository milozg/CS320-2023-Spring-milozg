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

fun pop_last(xs : 'a list) : 'a list * 'a =
    let
        val rev = list_reverse(xs)
    in
        case xs of
            [x] => ([],x)
        | x :: xs => (list_reverse(xs),x)
    end

fun
list_pairing
(xs: 'a list): ('a * 'a) list * 'a option =
    case xs of
        [] => ([], NONE)
     | [x]=> ([], SOME(x))
     | x :: xs => let
                    val (ys,last) = pop_last(xs)
                    val (reslist, res) = list_pairing(ys)
                  in
                    ((x,last) :: reslist, res)
                  end

(* ****** ****** *)

(* end of [CS320-2023-Spring-midterm1-list_pairing.sml] *)