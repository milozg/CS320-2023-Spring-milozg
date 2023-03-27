(* ****** ****** *)
use
"./../../../../mysmlib/mysmlib-cls.sml";

use
"./../../../../mysmlib/mysmlib-ind.sml";
(* ****** ****** *)

(*
HX-2023-03-24: 10 points
The following is a well-known series:
ln 2 = 1 - 1/2 + 1/3 - 1/4 + ...
Please implement a stream consisting of all the partial
sums of this series.
The 1st item in the stream equals 1
The 2nd item in the stream equals 1 - 1/2
The 3rd item in the stream equals 1 - 1/2 + 1/3
The 4th item in the stream equals 1 - 1/2 + 1/3 - 1/4
And so on, and so forth
//
*)

(* ****** ****** *)

val get_sum_at : int -> real =
    fn(n) => int1_foldleft(n, 0.0, fn(r,i) => if i = 0 then
                                                1.0
                                              else if (i+1) mod 2 = 0 then
                                                r - 1.0/Real.fromInt(i+1)
                                              else
                                                r + 1.0/Real.fromInt(i+1))


(* Used a stream tabulate I implemented in my library that
is the exact same as the one on the class library, but
it lets you include a start point for the function rather
than just using 0 *)
val the_ln2_stream: real stream =
    stream_tabulate_start(~1, 1, fn(i) => get_sum_at(i))


(* ****** ****** *)

(* end of [CS320-2023-Spring-assign06-01.sml] *)
