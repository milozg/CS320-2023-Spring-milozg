(* ****** ****** *)

use "./../../mysmlib/mysmlib-cls.sml";

(* ****** ****** *)

(*
//
// HX-2023-04-20: 20 points
//
A sequence xs of integers captures '231'
if there are three integers a, b, and c
appearing as a subsequence of in satisfying
c < a < b. Note that a, b, and c doe not have
to appear consecutively in xs.

For instance, [1,3,4,2] does capture '231'
For instance, [1,2,4,3] does not capture '231'
For instance, [1,2,3,4] does not capture '231'
*)

(* ****** ****** *)

fun interLeave(curr : 'a, xs : 'a list): 'a list stream = fn() =>
(
    case (curr,xs) of
        (x,[]) => strcon_cons([x], stream_nil())
    |(x,(h :: t)) => strcon_cons((x::h::t), interLeave(x,t))
)

fun stream_permute_list(xs: 'a list): 'a list stream =
(
    case xs of
        [] => stream_cons([], stream_nil())
    |x :: xs => stream_append(interLeave(x,xs), stream_permute_list(xs))
)

(* ****** ****** *)

fun test(xs : int list) : bool =
    let
        val [x,y,z] = xs
    in
        x < y andalso y < z
    end

fun perm_capture_231(xs: int list) : bool =
    let
        fun help(xs: int list) : int list stream =
            stream_make_filter(stream_permute_list(xs), fn(x) => ((list_length(x) = 3) andalso test(x)))
    in
        stream_length(help(xs)) > 0
    end


(* ****** ****** *)

(* end of [CS320-2023-Spring-midterm2-05.sml] *)
