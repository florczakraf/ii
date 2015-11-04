(* zadanie 5. *)

type 'a btree = Leaf | Node of 'a btree * 'a * 'a btree;;

let rec fact_cps n k = if n = 0 then k 1 else fact_cps (n-1) (fun v -> k (n*v));;
fact_cps 4 (fun v-> v);;

let rec prod_cps k = function
  | Leaf -> k 1
  | Node (l, n, r) -> prod_cps (fun v -> k (prod_cps (fun v -> v) l *  n * v)) r;;
  
let prod t = prod_cps (fun v -> v) t;;

let rec prod_cps' k top = function
  | Leaf -> k 1
  | Node (_, 0, _) -> top 0
  | Node (l, n, r) -> prod_cps' (fun v -> k (prod_cps' (fun v -> v) top l * n * v)) top r;;
  
let prod' t = prod_cps' (fun v -> v) (fun v -> v) t;;
  
(* testy *)

let test_tree = Node (Node (Leaf, 2, Leaf), 2, Node (Leaf, 3, Node (Leaf, 1, Leaf)));;
let test_tree2 = Node (Node (Leaf, 2, Leaf), 2, Node (Leaf, 0, Node (Leaf, 1, Leaf)));;
prod test_tree = 12;;
prod test_tree2 = 0;;
prod' test_tree = 12;;
prod' test_tree2 = 0;;

