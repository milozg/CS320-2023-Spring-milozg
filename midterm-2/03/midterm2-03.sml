(* ****** ****** *)

use "./../../mysmlib/mysmlib-cls.sml";

(* ****** ****** *)
(*
HX-2023-04-20:
Given a finite or infinite stream fxss of
infinite streams: fxs_0, fxs_1, fxs_2, ...,
stream_zipstrm(fxss) returns an infinite stream
of streams: gxs_0, gxs_1, gxs_2, ..., where we have
gxs_j[i] = fxs_i[j]. Note that this is just the
stream version of stream_ziplst (see Assign07-01).
*)
(* ****** ****** *)
fun get_heads_and_tails(strs : 'a stream stream) : ('a stream * 'a stream stream) option =
    let
        val help1 = fn(strs) => stream_make_map(strs, fn(s) => stream_head(s))
        val help2 = fn(strs) => stream_make_map(strs, fn(s) => stream_tail(s))
    in
        SOME(help1(strs),help2(strs)) handle Empty => NONE
    end

fun stream_zipstrm( fxss: 'a stream stream): 'a stream stream = fn() =>
    (
        case get_heads_and_tails(fxss) of
            NONE => strcon_nil
        | SOME(heads,tails) => strcon_cons(heads, stream_zipstrm(tails))
    )


(* ****** ****** *)

(* end of [CS320-2023-Spring-midterm2-03.sml] *)
