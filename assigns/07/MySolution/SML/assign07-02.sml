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

fun cube(n : int) : int =
    n*n*n

fun mini_stream(n : int) : (int * int) stream =
    stream_tabulate(n+1, fn (i) => (i,n))


fun check_next(pair : (int * int), inc : int, str : (int * int) stream) : (int * int) stream * int =
    let
        val (i1,j1) = pair
        val (i2,j2) = stream_get_at(str, inc)
    in
        case cube(i1) + cube(j1) <= cube(i2) + cube(j2) of
            true => (fn() => strcon_cons(pair,fn() => strcon_nil),inc)
        |  false => let val (fxs,i) = check_next(pair,inc+1,str)
                    in
                        (fn() => strcon_cons((i2,j2), fxs),i)
                    end
    end


val
natPairsWrongOrder: (int * int) stream =
    stream_concat(stream_tabulate(~1, fn(i) => mini_stream(i)))

val
theNatPairs_cubesum: (int * int) stream =
let
    fun helper(inc : int, str : (int*int) stream) : (int * int) stream =
        let
            val (mini,i) = check_next(stream_get_at(str,inc), inc + 1, str)
        in
            stream_append(mini, helper(i+1,str))
        end
in
    helper(0,natPairsWrongOrder)
end



(* end of [CS320-2023-Spring-assign07-02.sml] *)
