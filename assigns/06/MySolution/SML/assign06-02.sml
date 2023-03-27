(* ****** ****** *)
use
"./../../../../mysmlib/mysmlib-cls.sml";
(* ****** ****** *)

(*
HX-2023-03-24: 10 points
Please enumerate all the pairs of natural
numbers. Given pairs (i1, j1) and (i2, j2),
(i1, j1) should be enumerated ahead of (i2, j2)
if i1+j1 < i2+j2.
*)

(* ****** ****** *)

fun mini_stream(n : int): (int*int) stream =
    stream_tabulate(n+1, fn (i) => (i,n-i))


val theNatPairs: (int*int) stream =
    stream_concat(stream_tabulate(~1, fn(i) => mini_stream(i)))


(* ****** ****** *)

(* end of [CS320-2023-Spring-assign06-02.sml] *)
