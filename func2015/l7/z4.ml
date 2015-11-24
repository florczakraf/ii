let (fresh, reset) =
  let n = ref 0
  in let fresh x = n := !n + 1;
                   x ^ string_of_int !n
     and reset nr = n := nr
     in (fresh, reset);;

(* testy *)

fresh "x";;
fresh "x";;
fresh "x";;
fresh "y";;

reset 1;;
fresh "x";;
fresh "x";;
