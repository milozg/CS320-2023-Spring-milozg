use "assign00-lib.sml";

fun int2str(i0: int): string =
    case (i0 - 10) < 0 of
        true => str(chr(ord(#"0") + i0))
     | false => let val d1 = str(chr(ord(#"0") + (i0 mod 10)))
                    val ds = int2str(i0 div 10)
                in
                    ds ^ d1
                end;

(* val i2st1 = int2str(430); *)
