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
fun stream_merge2(fxs1: 'a stream, fxs2: 'a stream, lte3: 'a * 'a -> bool) : 'a stream =
    fn() =>
    (
        case fxs1() of
            strcon_nil => fxs2()
        | strcon_cons(x1, fxs1) => case fxs2() of
                                    strcon_nil => strcon_cons(x1, fxs1)
                                | strcon_cons(x2,fxs2) => if lte3(x1,x2)
                                                            then strcon_cons(x1, stream_merge2(fxs1,stream_cons(x2,fxs2), lte3))
                                                            else strcon_cons(x2, stream_merge2(stream_cons(x1,fxs1),fxs2,lte3))
    )


fun cube(n : int) : int =
    n*n*n

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

fun first_level_stream(n : int) : (int * int) stream =
    stream_tabulate_from(~1, n, fn(i) => (n,i))

val
theNatPairs_cubesum: (int * int) stream =
    let
        fun help(n : int) : (int * int) stream = fn() =>
            (
                strcon_cons((0,n), stream_merge2(first_level_stream(n), help(n+1), fn((i1,j1),(i2,j2)) =>
                                                    cube(i1)+cube(j1) <= cube(i2)+cube(j2)))
            )
    in
        stream_cons((0,0), help(1))
    end



(* end of [CS320-2023-Spring-assign07-02.sml] *)
