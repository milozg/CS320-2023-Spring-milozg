use "./../../../mysmlib/mysmlib-cls.sml";

fun quiz02_01 (word : string) : char -> int =
    fn (c : char) =>
        list_length(foreach_to_filter_list(string_foreach)(word, fn(x) => x = c))

val () =
assert320
(quiz02_01("$abb^cccdddd")(#"0") = 0)
val () =
assert320
(quiz02_01("$abb^cccdddd")(#"1") = 0)
val () =
assert320
(quiz02_01("$abb^cccdddd")(#"a") = 1)
val () =
assert320
(quiz02_01("$abb^cccdddd")(#"b") = 2)
val () =
assert320
(quiz02_01("$abb^cccdddd")(#"c") = 3)
val () =
assert320
(quiz02_01("$abb^cccdddd")(#"d") = 4)
val () =
assert320
(quiz02_01("$abb^cccdddd")(#"X") = 0)
val () =
assert320
(quiz02_01("$abb^cccdddd")(#"Y") = 0)
val () =
assert320
(quiz02_01("$abb^cccdddd")(#"Z") = 0)
val () =
assert320
(quiz02_01("$abb^cccdddd")(#"$") = 1)
val () =
assert320
(quiz02_01("$abb^cccdddd")(#"^") = 1)
