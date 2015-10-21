(* zadanie 1. *)

(* Nie potrafie napisac wersji bez generowania nieuzytkow *)

let rec sublists xs =
  match xs with
    []    -> [[]]
  | x::xs -> (List.map (fun xs -> x::xs) (sublists xs)) @ (sublists xs);;

sublists [1;2;3];;
