(* zadanie 3. *)

type 'a mtree_lst = MTree of 'a * ('a mtree_lst) list;;
type 'a mtree = MNode of 'a * 'a forest
 and 'a forest = EmptyForest | Forest of 'a mtree * 'a forest;;

let dfs_lst t =
  let rec aux = function
    | [] -> []
    | s::stack -> let MTree (n, ns) = s
                  in n::(aux (ns@stack))
  in aux [t];;

let bfs_lst t =
  let rec aux = function
    | [] -> []
    | q::queue -> let MTree (n, ns) = q
                  in n::(aux (queue@ns))
  in aux [t];;

let rec forest_append f1 f2 =
  match f1 with
    EmptyForest -> f2
  | Forest (t, f) -> Forest (t, forest_append f f2);;
  
let dfs_forest t =
  let rec aux = function
    | EmptyForest -> []
    | Forest (s, stack) -> let MNode (n, ns) = s
                           in n::(aux (forest_append ns stack))
  in aux t;;

let bfs_forest t =
  let rec aux = function
    | EmptyForest -> []
    | Forest (q, queue) -> let MNode (n, ns) = q
                           in n::(aux (forest_append queue ns))
  in aux t;;

(* testy *)

(*
   1
  / \
 2  4
 |
 3
*)
  
let mtreelst = MTree (1, [MTree (2, [MTree (3, [])]); MTree (4, [])]);;
dfs_lst mtreelst = [1;2;3;4];;
bfs_lst mtreelst = [1;2;4;3];;

let mtreeforest = Forest (MNode (1, Forest (MNode (2, Forest (MNode (3, EmptyForest), EmptyForest)), Forest (MNode (4, EmptyForest), EmptyForest))), EmptyForest);; 
dfs_forest mtreeforest = [1;2;3;4];;
bfs_forest mtreeforest = [1;2;4;3];;

