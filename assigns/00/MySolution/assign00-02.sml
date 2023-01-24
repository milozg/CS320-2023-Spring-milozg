fun firstFactor(n : int, i : int) : int =
    case n = i of
        true => n
      |false => case n mod i of
                    0 => i
                  | _ => firstFactor(n,i+1)

(* val fft1 = firstFactor(2003,2);
val fft2 = firstFactor(13,2);
val fft3 = firstFactor(14,2);
val fft4 = firstFactor(81,2); *)

fun isPrime(n0: int): bool =
    case n0 of
        0 => false
       |1 => false
       |_ => (firstFactor(n0,2) = n0)

(* val ipt1 = isPrime(13);
val ipt2 = isPrime(14);
val ipt3 = isPrime(0);
val ipt4 = isPrime(1);
val ipt5 = isPrime(2003); *)
