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
Assign01-02: 10 points
//
Please implement a function
that does subscripting on xlist DIRECTLY:
//
fun xlist_sub(xs: 'a xlist, i0: int): 'a
//
If 'i0' is an illegal index, then xlist_sub
should raise the XlistSubscript exception.
//
You should NOT convert xlist into list and
then do subscripting.
//
*)

fun xlist_sub(xs: 'a xlist, i0: int): 'a =
    let
        fun loop(xs : 'a xlist, i0 : int, j : int) : 'a =
            case xs of
            xlist_nil => raise XlistSubscript
            |
            xlist_cons(x1, xs) => if j = i0 then x1 else loop(xs,i0,j + 1)
            |
            xlist_snoc(xs, x1) => list_of_xlist(xs) @ [x1]
            |
            xlist_append(xs, ys) => list_of_xlist(xs) @ list_of_xlist(ys)
            |
            xlist_reverse(xs) => list_reverse(list_of_xlist(xs))
