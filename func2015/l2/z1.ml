(* zadanie 1. *)

let rec sublists xs =
  match xs with
    []    -> [[]]
  | x::xs -> (List.map (fun xs -> x::xs) (sublists xs)) @ (sublists xs);;

sublists [1;2;3];;
