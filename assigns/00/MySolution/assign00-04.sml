use "../assign00-lib.sml";


(*
Assign00-04: 10 points
Please implement a function that converts a given
string to an integer:
fun str2int(cs: string): int
In particular, it is expected that str2int(int2str(x)) = x
*)

fun removeLast(s : string) : string =
    let
    fun help(i : int,cs : string,l : int) : string =
        case i >= (l-1) of
            true => ""
          |false => str(strsub(s,i)) ^ help(i+1,s,l)
    in
        help(0,s,strlen(s))
    end

fun str2int(cs: string): int =
    case cs of
        "" => 0
       | _ => let val q = (ord(strsub(cs,(strlen(cs)-1))) - 48)
                  val r = str2int(removeLast(cs))
              in
                    q + (10 * r)
              end
