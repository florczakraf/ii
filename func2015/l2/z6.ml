(* zadanie 6. *)

let suffixes xs =
  let rec aux acc xs =
    match xs with
      []    -> acc
    | x::xs -> aux ((x::xs)::acc) xs
  in
  List.rev (aux [] xs);;

let prefixes xs =
  let rec aux acc xs =
    match xs with
      []    -> acc
    | x::xs -> aux (((List.hd acc)@[x])::acc) xs
  in
  match xs with
    []    -> []
  | x::xs ->  List.rev (aux [[x]] xs);;
  
suffixes [1;2;3];;
prefixes [1;2;3];;

