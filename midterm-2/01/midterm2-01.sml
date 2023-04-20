(* ****** ****** *)

use "./../../mysmlib/mysmlib-cls.sml";

(* ****** ****** *)

(*
//
// HX-2023-04-20: 20 points
//
Given a stream fxs of real numbers a0, a1, a2, ...
and a real number x0, stream_evaluate(fxs, x0)
returns another stream of real number that enumerates
all of the following partial sums:
a0, a0 + a1*x0, a0 + a1*x0 + a2*x0^2, ...
The general form of the enumerated sums is given as follows:
(a0 + a1*x0 + a2*x0^2 + ... + an * x0^n)
//
Assume:
a0 = 0, a1 = 1, a2 = -1/2, a3 = 1/3, a4 = -1/4, ...
Then we have ln2 = stream_evaluate(fxs, 1.0) // see Assign06-01
//
*)

(* ****** ****** *)
fun
pow_real_real
(x: real, y: real): real =
if y <= 0.0
then 1.0 else x * pow_real_real(x, y-1.0)

fun sum_n(fxs : real stream, n : int): real =
    int1_foldleft(n+1, 0.0, fn(r, i) => r + stream_get_at(fxs,i))

fun stream_evaluate (fxs: real stream, x0: real): real stream =
    let
        val enums = stream_make_imap(fxs, fn(i,a) => a*(pow_real_real(x0,Real.fromInt(i))))
    in
        stream_tabulate(~1, fn(i) => sum_n(enums, i))
    end


(* ****** ****** *)

(* end of [CS320-2023-Spring-midterm2-01.sml] *)
