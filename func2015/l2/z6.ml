(* zadanie 6. *)

let rec suffixes xs =
  match xs with
    [] -> []
  | x::xs -> (x::xs)::suffixes xs;;

let prefixes xs =
  List.tl (List.rev (List.fold_left(fun acc e -> ((List.hd acc)@[e])::acc) [[]] xs));;

suffixes [1;2;3];;
prefixes [1;2;3];;
