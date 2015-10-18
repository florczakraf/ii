let concat x xs =
  x :: xs

let rec sublists xs =
  match xs with
    []      -> [[]]
  | x :: xs -> (List.map (concat x) (sublists xs)) @ (sublists xs);;

  (* test *)
sublists [1;2;3];;
