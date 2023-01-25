use "../assign00-lib.sml";

fun removeFirst(s : string, l : int) : string =
    case l - 1 of
        0 => ""
      | _ => removeFirst(s,l-1) ^ str(strsub(s,l-1));

val rft1 = removeFirst("Hello",5);
val rft2 = removeFirst("a",1);

fun stringrev(cs: string): string =
    case cs of
        "" => ""
        |_ => let val n = stringrev(removeFirst(cs,strlen(cs)))
                  val m = str(strsub(cs,0))
              in
                  n ^ m
              end;

(* val srt1 = stringrev("abcdef"); *)
