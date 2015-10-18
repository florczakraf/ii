let rec replace_nth (xs, i, r) =
  match xs with
    []      -> []
  | x :: xs -> match i with
                 0 -> r :: xs
               | _ -> x :: replace_nth (xs, i - 1, r);;

replace_nth ([1;2;3], 1, 5);;
