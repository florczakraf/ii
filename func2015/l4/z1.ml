(* zadanie 1. *)

let is_palindrome lst =
  let rec aux acc slow fast =
    match slow, fast with
      slow, [] -> acc = slow
    | _::slow, _::[] -> acc = slow
    | s::slow, _::_::fast -> aux (s::acc) slow fast
  in aux [] lst lst;;
  
is_palindrome [1;2;1] = true;;
is_palindrome ['a';'b';'b';'a'] = true;;
is_palindrome [2;4;3;2] = false;;

    
