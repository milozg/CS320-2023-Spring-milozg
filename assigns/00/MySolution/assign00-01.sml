fun fact(x: int): int =
  if x > 0 then x * fact(x-1) else 1


(*
Assign00-01: 10 points
Please find the first integer N such that the
evaluation of fact(N) in SML/NJ yields an Overflow
exception.
*)

fun findOver(x: int) : int =
    fact(x) handle Overflow => 0;

fun findN(x: int) : int =
    case findOver(x) of
        0 => x
      | _ => findN(x+1)


val N = findN(0);
