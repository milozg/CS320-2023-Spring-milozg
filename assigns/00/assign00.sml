(* ****** ****** *)
(*
Assign00: Warmup!
*)
(* ****** ****** *)

use "assign00-lib.sml";


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

val n = findN(0);

(*
Assign00-02: 10 points
Please implement a function that tests whether a
given natural number is a prime:
fun isPrime(n0: int): bool
*)

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

(*
Assign00-03: 10 points
Please implement a function that converts a given
integer to a string that represents the integer:
fun int2str(i0: int): string
*)

fun int2str(i0: int): string =
    case (i0 - 10) < 0 of
        true => str(chr(ord(#"0") + i0))
     | false => let val d1 = str(chr(ord(#"0") + (i0 mod 10)))
                    val ds = int2str(i0 div 10)
                in
                    ds ^ d1
                end;

(* val i2st1 = int2str(430); *)

(*
Assign00-04: 10 points
Please implement a function that converts a given
string to an integer:
fun str2int(cs: string): int
In particular, it is expected that str2int(int2str(x)) = x
*)

(* ****** ****** *)

(*
Assign00-05: 10 points
Please implement a function that returns the reverse of
a given string:
fun stringrev(cs: string): string
*)

fun removeFirst(s : string, l : int) : string =
    case l - 1 of
        0 => ""
      | _ => removeFirst(s,l-1) ^ str(String.sub(s,l-1));

val rft1 = removeFirst("Hello",5);
val rft2 = removeFirst("a",1);

fun stringrev(cs: string): string =
    case cs of
        "" => ""
        |_ => let val n = stringrev(removeFirst(cs,String.size(cs)))
                  val m = str(String.sub(cs,0))
              in
                  n ^ m
              end;

(* val srt1 = stringrev("abcdef"); *)

(* end of [CS320-2023-Spring-assign00.sml] *)
