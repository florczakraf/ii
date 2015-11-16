type 'a btree = Leaf of 'a | Node of 'a btree * 'a * 'a btree;;

let number_preorder t =
  let rec aux n cont = function
    | Leaf _ -> cont ((Leaf n), n)
    | Node (l, _, r) -> aux (n + 1) (fun (lt, ln) -> aux (ln + 1) (fun (rt, rn) -> cont (Node (lt, n, rt), rn)) r) l
  in fst (aux 1 (fun x -> x) t);;

let t = Node (Node (Leaf 'a', 'b', Leaf 'c'), 'd', Leaf 'e');;

number_preorder t = Node (Node (Leaf 3, 2, Leaf 4), 1, Leaf 5);;

