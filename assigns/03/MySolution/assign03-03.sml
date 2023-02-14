(* ****** ****** *)
(*
use "./../assign03.sml";
use "./../assign03-lib.sml";
*)
use "../../../mysmlib/mysmlib-ind.sml";

(* ****** ****** *)

(*
//
HX-2023-02-10: 10 points
The function list_tabulate takes an integer
[n] and a function [f] and returns a list that
equals [f(0), f(1), ..., f(n-1)]
//
list_tabulate(n: int, f: int -> 'a): 'a list
//
*)

fun list_range(start : int, finish : int) : int list =
    let
        fun loop(s : int, f : int, xs : int list): int list =
            case s >= f of
                true => xs
             | false => loop(s + 1, f, s :: xs)
    in
        list_reverse(loop(start, finish, []))
    end

fun list_tabulate(n : int, f : int -> 'a) : 'a list = list_map(list_range(0,n),f)


(* ****** ****** *)

(* end of [CS320-2023-Spring-assign03-03.sml] *)
