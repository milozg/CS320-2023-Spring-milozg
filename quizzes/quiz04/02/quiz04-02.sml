(* ****** ****** *)
use "./../../../mysmlib/mysmlib-cls.sml";
(* ****** ****** *)

fun stream_dupremov(fxs : int stream) : int stream =
    stream_make_ifilter(fxs, fn(i, n) => i = 0 orelse n <> stream_get_at(fxs, i-1))

(* ****** ****** *)

(* end of [CS320-2023-Spring-quizzes-quiz04-02.sml] *)
