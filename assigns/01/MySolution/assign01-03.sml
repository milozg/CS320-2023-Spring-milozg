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
Assign01-03: 10 points
//
Please implement a function that converts a given
xlist 'xs' into another xlist 'ys' by removing the
constructor 'mylist_reverse':
//
fun xlist_remove_reverse(xs: 'a xlist): 'a xlist
//
In particular, your implementation should guarantee:
1. 'xs' and 'ys' represent the same list
2. 'ys' does NOT make any use of 'xlist_reverse'
3. 'xs' and 'ys' use the same number of 'xlist_append'
//
*)

fun xlist_remove_reverse(xs : 'a xlist) : 'a xlist =
    let fun help(xs : 'a xlist, r : bool) : 'a xlist =
        case xs of
            xlist_nil => xlist_nil
            |
            xlist_cons(x1, xs) => if r then xlist_snoc(help(xs,r),x1) else xlist_cons(x1,help(xs,r))
            |
            xlist_snoc(xs, x1) => if r then xlist_cons(x1,help(xs,r)) else xlist_snoc(help(xs,r),x1)
            |
            xlist_append(xs, ys) => if r then xlist_append(help(ys,r),help(xs,r)) else xlist_append(help(xs,r),help(ys,r))
            |
            xlist_reverse(xs) => if r then help(xs,false) else help(xs,true)
        in
            help(xs,false)
        end
