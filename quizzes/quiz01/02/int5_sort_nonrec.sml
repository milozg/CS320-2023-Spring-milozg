(* ****** ****** *)
(*
HX-2023-02-07: 50 points
*)
(* ****** ****** *)

type int2 = int * int
type int3 = int * int * int
type int4 = int * int * int * int
type int5 = int * int * int * int * int

(* ****** ****** *)

(*
The following function int5_sort
is based on ListMergeSort.sort, which is
defined recursively. Given a tuple of 5
integers, int5_sort returns an ordered tuple
of the same 5 integers. For instance,
int5_sort(1, 2, 1, 2, 2) = (1, 1, 2, 2, 2)
int5_sort(3, 1, 2, 5, 2) = (1, 2, 2, 3, 5)
int5_sort(3, 1, 2, 5, 4) = (1, 2, 3, 4, 5)
*)

(*
val
int5_sort =
fn(xs: int5): int5 =
let
val (x1, x2, x3, x4, x5) = xs
val ys =
ListMergeSort.sort(op>=)[x1,x2,x3,x4,x5]
val y1 = hd(ys) and ys = tl(ys)
val y2 = hd(ys) and ys = tl(ys)
val y3 = hd(ys) and ys = tl(ys)
val y4 = hd(ys) and ys = tl(ys)
val y5 = hd(ys) and ys = tl(ys)
in
  (y1, y2, y3, y4, y5)
end
*)

(* ****** ****** *)
(*
Please give a non-recursive implementation of int5_sort
as int5_sort_nr. That is, please implement int5_sort_nr
in a non-recursive manner such that int5_sort(xs) equals
int5_sort_nr(xs) for every 5-tuple xs of the type int5.
*)
(* ****** ****** *)

fun int5_sort_nr(xs: int5): int5 =
    let
        fun sort2(x1 : int, x2 :int) : (int * int) =
            case x1 > x2 of
                true => (x2,x1)
                |false => (x1,x2)

        fun sort3(x1 : int, x2 : int, x3 : int) : int * int * int =
            let
                val (s1,s2) = sort2(x1,x2)
            in
                case x3 > s2 of
                    true => (s1,s2,x3)
                  |false => case x3 > s1 of
                                true => (s1,x3,s2)
                                |false => (x3,s1,s2)
            end

        fun sort4(x1 : int, x2 : int, x3 : int, x4 : int) : int * int * int * int =
            let
                val (s1,s2,s3) = sort3(x1,x2,x3)
            in
                case x4 > s3 of
                    true => (s1,s2,s3,x4)
                    |false => case x4 > s2 of
                                true => (s1,s2,x4,s3)
                                |false => case x4 > s1 of
                                            true => (s1,x4,s2,s3)
                                            |false => (x4,s1,s2,s3)
            end

        fun sort5(x1 : int, x2 : int, x3 : int, x4 : int, x5 : int) : int * int * int * int * int =
            let
                val (s1,s2,s3,s4) = sort4(x1,x2,x3,x4)
            in
                case x5 > s4 of
                    true => (s1,s2,s3,s4,x5)
                    |false => case x5 > s3 of
                                true => (s1,s2,s3,x5,s4)
                                |false => case x5 > s2 of
                                            true => (s1,s2,x5,s3,s4)
                                            |false => case x5 > s1 of
                                                        true => (s1,x5,s2,s3,s4)
                                                        |false => (x5,s1,s2,s3,s4)
            end
        val(i1,i2,i3,i4,i5) = xs
    in
        sort5(i1,i2,i3,i4,i5)
    end

(* Please Give your implementation as follows: *)



(* ****** ****** *)

(* end of [CS320-2023-Spring-quiz01-int5_sort_nonrec.sml] *)
