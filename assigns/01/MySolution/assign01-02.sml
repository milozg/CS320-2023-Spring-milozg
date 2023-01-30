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

fun rev(xs : 'a xlist) : 'a xlist =
    case xs of
        xlist_nil => xlist_nil
        |
        xlist_cons(x1, xs) => xlist_snoc(rev(xs),x1)
        |
        xlist_snoc(xs, x1) => xlist_cons(x1,rev(xs))
        |
        xlist_append(xs, ys) => xlist_append(rev(ys),rev(xs))
        |
        xlist_reverse(xs) => xs

fun xlist_sub(xs: 'a xlist, i0: int): 'a =
    let
        fun loop(xs : 'a xlist, i0 : int, j : int, l : int) : 'a =
            case xs of
            xlist_nil => raise XlistSubscript
            |
            xlist_cons(x1, xs) => if i0 = j then x1 else loop(xs,i0,j+1,l)
            |
            xlist_snoc(xs, x1) => if i0 = l-1 then x1 else loop(xs,i0,j,l-1)
            |
            xlist_append(xs, ys) => if i0 - j < xlist_size(xs) then loop(xs,i0-j,0,xlist_size(xs)) else loop(ys,i0-j-xlist_size(xs),0,xlist_size(ys))
            |
            xlist_reverse(xs) => loop(rev(xs),i0,j,l)
    in
        loop(xs,i0,0,xlist_size(xs))
    end
