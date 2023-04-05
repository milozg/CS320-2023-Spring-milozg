(* ****** ****** *)
use "./../../../mysmlib/mysmlib-cls.sml";
(* ****** ****** *)

val
theAlphabet =
"ABCDEFGHIJKLMNOPQRSTUVWXYZ"

fun alphabeta_cycling_list(): char stream = fn() =>
    stream_append(string_streamize(theAlphabet), alphabeta_cycling_list())()

(* ****** ****** *)

(* end of [CS320-2023-Spring-quizzes-quiz04-01.sml] *)
