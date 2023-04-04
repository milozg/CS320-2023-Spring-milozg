(* ****** ****** *)
use
"./../../../../mysmlib/mysmlib-cls.sml";
(* ****** ****** *)

(*
//
HX-2023-03-31: 20 points
Please implement the following function
that enumerates all the pairs (i, j) of natural
numbers satisfying $i <= j$; a pair (i1, j1) must
be enumerated ahead of another pair (i2, j2) if the
following condition holds:
  i1*i1*i1 + j1*j1*j1 < i2*i2*i2 + j2*j2*j2
//
val
theNatPairs_cubesum: (int * int) stream = fn () =>
//
*)

(* ****** ****** *)

val cube = fn(n : int) => n*n*n

fun mini_stream(n : int) : (int * int) stream =
    let
        fun help(pairs : ((int * int) * (int * int)) stream) : (int * int) stream = fn() =>
            (
                case pairs() of
                    strcon_nil => strcon_nil
                |strcon_cons((x1,x2),fxs) => case x1 = x2 of
                                                true => strcon_cons(x1, help(fxs))
                                               |false => strcon_cons(x1, stream_cons(x2,help(fxs)))
            )
    in
        help(stream_tabulate(n+1, fn(i) => ((n,i),(i,n))))
    end

val
theNatPairs_cubesum: (int * int) stream =
    stream_concat(stream_tabulate(~1, fn(i) => mini_stream(i)))


(* end of [CS320-2023-Spring-assign07-02.sml] *)
