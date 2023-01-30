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
Assign01-04: 10 points
//
Please recall the following question in Assign00:
Assign00-04: 10 points
Please implement a function that converts a given
string to an integer:
fun str2int(cs: string): int
In particular, it is expected that str2int(int2str(x)) = x
//
This time you are asked to implement the following
function that only turns a legal representation of an integer
into an integer. By a legal representation of an integer, we
mean a string consisting of a non-empty sequence of digits (where
the digit '0' can be a leading digit).
//
fun str2int_opt(cs: string): int option
//
*)

datatype int_opt_lst =
    int_opt_lst_nil
    |
    int_opt_lst_sng of int
    |
    int_opt_lst_snoc of (int_opt_lst * int)

fun check_num(i : int) : bool =
    if i >= 48 andalso i <= 57 then true else false

fun str2int_opt_lst (s : string) : int_opt_lst =
    let
        fun help(i : int,cs : string,l : int) : int_opt_lst =
            case l of
                0 => int_opt_lst_nil
              | 1 => case check_num(ord(strsub(cs,0))) of
                        false => int_opt_lst_nil
                       |true  => int_opt_lst_sng(ord(strsub(cs,0)) - 48)
              | _ => case check_num(ord(strsub(cs,strlen(cs)-1))) of
                        false => 
    in
        help(0,s,strlen(s))
    end


fun str2int_opt(cs: string): int option =
    case cs of
        "" => SOME(0)
       | _ => let val q = (ord(strsub(cs,(strlen(cs)-1))) - 48)
                  val r = str2int_opt(removeLast(cs))
              in
                    case check_num(q) of
                        true => SOME(q + (10 * r))
                       |false => NONE
              end
