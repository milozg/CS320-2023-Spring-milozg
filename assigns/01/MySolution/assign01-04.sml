use "../assign01-lib.sml";
use "../../00/assign00-lib.sml";
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

fun check_num(i : int) : bool =
    if (i >= 48 andalso i <= 57) then true else false

fun removeLast(s : string) : string =
    let
        fun help(i : int,cs : string,l : int) : string =
            case i >= (l-1) of
                true => ""
              |false => str(strsub(s,i)) ^ help(i+1,s,l)
    in
        help(0,s,strlen(s))
    end

fun check_string(s : string) : bool =
    let
        fun loop(i : int, s : string, l : int) : bool =
            case i < l of
                false => true
                |true => check_num(ord(strsub(s,i))) andalso loop(i+1,s,l)
        val l = strlen(s)
    in
        case l = 0 of
            true => false
           |false => loop(0,s,l)
    end

fun str2int_opt(cs: string): int option =
    let
        fun execute(cs:string) : int =
            case cs of
                "" => 0
                | _ => let val q = (ord(strsub(cs,(strlen(cs)-1))) - 48)
                           val r = execute(removeLast(cs))
                       in
                            q + (10 * r)
                       end
    in
        case check_string(cs) of
            false => NONE
           |true  => SOME(execute(cs))
    end
