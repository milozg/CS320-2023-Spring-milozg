(* ****** ****** *)
use
"./../../../../mysmlib/mysmlib-cls.sml";
(* ****** ****** *)

(*
HX-2023-03-14: 20 points
Recall that a reference is precisely an array
of size 1. And it can be treated as a sequence.
For instance, we can define ref_foreach as follows
*)

(* ****** ****** *)

fun
ref_foreach
(r0: 'a ref, work: 'a -> unit): unit = work(!r0)

(* ****** ****** *)

(*
Please implement directly the following combinators
for for references. That is, your implementation should
not make use of any third-order functions defined in the
library for this class.
*)

(* ****** ****** *)


fun
ref_get_at
(r0: 'a ref, i: int): 'a = !r0

fun
ref_forall
(r0: 'a ref, test: 'a -> bool): bool = test(!r0)

fun
ref_map_list
(r0: 'a ref, fopr: ('a) -> 'b): 'b list = [fopr(!r0)]

fun
ref_foldleft
(r0: 'a ref, res: 'r, fopr: ('r * 'a) -> 'r): 'r = fopr(res,!r0)

fun
ref_ifoldleft
(r0: 'a ref, res: 'r, fopr: ('r * i * 'a) -> 'r): 'r = fopr(res,0,!r0)


(* ****** ****** *)

(* end of [CS320-2023-Spring-assign05-01.sml] *)
