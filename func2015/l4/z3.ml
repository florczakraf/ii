type 'a mtree_lst = MTree of 'a * ('a mtree_lst) list;;
type 'a mtree = MNode of 'a * 'a forest
 and 'a forest = EmptyForest | Forest of 'a mtree * 'a forest;;

let dfs_lst t =
  let rec aux = function
    | [] -> []
    | s::stack -> let 
