use "../assign01-lib.sml";
(* ****** ****** *)
val list_append = op@
val list_reverse = List.rev
(* ****** ****** *)

exception XlistConsMatch
exception XlistSubscript

(* ****** ****** *)

datatype 'a xlist =
xlist_nil
|
xlist_cons of ('a * 'a xlist)
|
xlist_snoc of ('a xlist * 'a)
|
xlist_append of ('a xlist * 'a xlist)
|
xlist_reverse of ('a xlist)

(* ****** ****** *)

fun
list_of_xlist(xs: 'a xlist): 'a list =
(
case xs of
xlist_nil => []
|
xlist_cons(x1, xs) => x1 :: list_of_xlist(xs)
|
xlist_snoc(xs, x1) => list_of_xlist(xs) @ [x1]
|
xlist_append(xs, ys) => list_of_xlist(xs) @ list_of_xlist(ys)
|
xlist_reverse(xs) => list_reverse(list_of_xlist(xs))
)

(* ****** ****** *)

(*
//
Assign01-01: 10 points
//
Please implement a function
that computes the size of an xlist DIRECTLY:
//
fun xlist_size(xs: 'a xlist): int
//
That is, you should NOT convert xlist into list
and then compute the size of the converted list
//
*)

fun xlist_size(xs : 'a xlist) : int =
    let
        fun loop(xs : 'a xlist, i : int) : int =
            case xs of
            xlist_nil => i
            |
            xlist_cons(x1, xs) => loop(xs,i+1)
            |
            xlist_snoc(xs, x1) => loop(xs,i+1)
            |
            xlist_append(xs, ys) => loop(xs,i) + loop(ys,0)
            |
            xlist_reverse(xs) => loop(xs,i)
    in
        loop(xs,0)
    end
