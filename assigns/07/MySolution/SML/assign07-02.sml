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
fun
stream_tabulate_from
( n0: int
, start: int
, fopr: int -> 'a): 'a stream =
let
fun
fmain1
(i0: int): 'a stream = fn() =>
strcon_cons(fopr(i0), fmain1(i0+1))
fun
fmain2
(i0: int): 'a stream = fn() =>
if
i0 >= n0
then strcon_nil else
strcon_cons(fopr(i0), fmain2(i0+1))
in
if n0 < 0 then fmain1(start) else fmain2(start)
end

fun cube(n : int) : int =
    n*n*n

fun first_level_stream(n : int) : (int * int) stream =
    stream_tabulate_from(~1, n, fn(i) => (n,i))

(* val
theNatPairs_cubesum: (int * int) stream =
    let
        fun help(n : int) : (int * int) stream =
            stream_merge(first_level_stream(n), help(n+1), fn((i1,j1),(i2,j2)) =>
                                                    cube(i1)+cube(j1) <= cube(i2)+cube(j2)
                        )
    in
        help(0)
    end *)


(* end of [CS320-2023-Spring-assign07-02.sml] *)
