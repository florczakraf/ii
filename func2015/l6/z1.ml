type 'a btree = Leaf of 'a | Node of 'a btree * 'a btree;;
type 'a llist = LNil | LCons of 'a * 'a llist Lazy.t;;
  
let rec fringe = function
  | Leaf v -> [v]
  | Node (l, r) -> (fringe l) @ (fringe r);;

let same_fringe t1 t2 = (fringe t1) = (fringe t2);;

let same_fringe' t1 t2 =
  let rec tree_to_llist cont = function
    | Leaf v -> LCons (v, cont)
    | Node (l, r) -> tree_to_llist (lazy (tree_to_llist cont r)) l
  in let rec aux l1 l2 =
       match l1, l2 with
         LNil, LNil -> true
       | LCons (v1, cont1), LCons (v2, cont2) -> v1 = v2 && aux (Lazy.force cont1) (Lazy.force cont2)
       | _ -> false
     in aux (tree_to_llist (lazy LNil) t1) (tree_to_llist (lazy LNil) t2);;
                    
(* testy *)
  
let t1 = Node (Node (Leaf 1, Leaf 2), Leaf 3);;
let t2 = Node (Leaf 1, Node (Leaf 2, Leaf 3));;
let t3 = Node (Leaf 1, Node (Leaf 3, Leaf 2));;
  
same_fringe t1 t2 = true;;
same_fringe t1 t3 = false;;
same_fringe' t1 t2 = true;;
same_fringe' t1 t3 = false;;
