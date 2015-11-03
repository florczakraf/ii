type 'a btree = Leaf | Node of 'a btree * 'a * 'a btree

let is_balanced t =
  let rec b_s = function
    | Leaf -> (true, 0)
    | Node (l, _, r) -> let l_size = b_s l and r_size = b_s r
                        in let diff = snd l_size - snd r_size
                           in (fst l_size && fst r_size &&
                                 diff >= -1 && diff <= 1,
                               snd l_size + snd r_size + 1)
  in fst (b_s t);;

let halve lst =
  let rec aux acc lst = function
    | 0 -> (List.rev acc, lst)
    | i -> aux ((List.hd lst)::acc) (List.tl lst) (i - 1)
  in aux [] lst (List.length lst / 2);;
  
let rec create_btree = function
  | [] -> Leaf
  | x::xs -> let (ls, rs) = halve xs
             in Node (create_btree ls, x, create_btree rs);;

let preorder t =
  let rec aux acc = function
    | Leaf -> acc
    | Node (l, n, r) -> n::aux (aux acc r) l
  in aux [] t;;
  
  
is_balanced (Node ((Node ((Node ((Node (Leaf, 3, Leaf)), 2, Leaf)), 1, Leaf)), 0, Leaf))  = false;;
is_balanced Leaf = true;;
is_balanced (Node (Leaf, 0, Leaf)) = true;;
is_balanced (Node (Leaf, 0, Node (Leaf, 1, Node (Leaf, 2, Leaf)))) = false;;
is_balanced (Node (Leaf, 0, Node (Leaf, 1, Leaf))) = true;;

preorder (Node ((Node ((Node ((Node (Leaf, 3, Leaf)), 2, Leaf)), 1, Leaf)), 0, Leaf)) = [0;1;2;3];;
preorder Leaf = [];;
preorder (Node (Leaf, 1, Leaf)) = [1];;

preorder (create_btree [1;2;3;4]) = [1;2;3;4];;
preorder (create_btree [1]) = [1];;

