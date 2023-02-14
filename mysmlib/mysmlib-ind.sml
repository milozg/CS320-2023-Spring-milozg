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

fun rappend(xs : 'a list, ys : 'a list) : 'a list =
    case xs of
        [] => ys
    | x :: xs => rappend(xs, x :: ys)

fun list_reverse(xs : 'a list) : 'a list = rappend(xs,[])

fun list_map(xs : 'a list , f : 'a -> 'b) : 'b list =
    let
        fun loop(xs : 'a list , f : 'a -> 'b , i : 'b list) : 'b list =
            case xs of
                [] => i
             | x :: xs => loop(xs, f, f(x) :: i)
    in
        list_reverse(loop(xs,f,[]))
    end

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

(* end of [BUCASCS320-2023-Spring-mysmlib-ind.sml] *)
