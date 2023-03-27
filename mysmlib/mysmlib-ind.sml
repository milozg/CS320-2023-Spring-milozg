(* ****** ****** *)
(*
HX-2023-01-22:
Library functions
for BUCASCS320-2023-Spring
This is an individual library, which
is not shared by the class.
//
Please build it up for your OWN use.
//
*)


(* ****** ****** *)

fun list_size(xs : 'a list) : int =
    let
        fun help(xs : 'a list, i : int) : int =
            case xs of
                [] => i
            | x :: xs => help(xs, i + 1)
    in
        help(xs,0)
    end

fun list_size_compare(xs : 'a list, ys : 'a list) : 'a list =
    case list_size(xs) >= list_size(ys) of
        true => xs
     | false => ys

 (* ****** ****** *)

 datatype 'a strcon =
   strcon_nil
 | strcon_cons of
   ('a * (unit -> 'a strcon))

 (* ****** ****** *)

 type 'a stream = (unit -> 'a strcon)

 (* ****** ****** *)

 fun
 stream_nil
 ((*void*)) =
   fn () => strcon_nil(*void*)
 fun
 stream_cons
 ( x1: 'a
 , fxs
 : 'a stream) =
    fn () => strcon_cons(x1, fxs)

 (* ****** ****** *)




fun
stream_tabulate_start
( n0: int, start: int
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




(* ****** ****** *)

(* end of [BUCASCS320-2023-Spring-mysmlib-ind.sml] *)
