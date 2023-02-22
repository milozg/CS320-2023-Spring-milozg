use "./../../../mysmlib/mysmlib-cls.sml";

fun quiz02_02
(xs : int list, ys : int list) : bool =
    not (list_forall(xs, fn(x) => list_forall(ys, fn(y) => abs_int(x - y) >= 10)))

val xs = []
val ys = [1,2,3]
val () =
assert320
(quiz02_02(xs,ys) = false)

val xs = [1,2,3,4,5]
val ys = [15,20,30,40,50]
val () =
assert320
(quiz02_02(xs,ys) = false)

val xs = [1,2,3,4,5]
val ys = [15,20,30,40,~8]
val () =
assert320
(quiz02_02(xs,ys) = true)
