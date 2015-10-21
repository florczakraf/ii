(* zadanie 5. *)

(* permutacje uzyskuje przez doczepienie do elementu wszystkich permutacji listy o 1 krotszej (tj. bez tego elementu) *)
let rec permutations xs =
  match xs with
    []    -> []
  | x::[] -> [[x]]
  | xs    -> List.fold_left (fun acc x -> acc @ List.map (fun perm -> x::perm) (permutations (List.filter ((<>) x) xs))) [] xs;;
  
permutations [1;2;3];;

