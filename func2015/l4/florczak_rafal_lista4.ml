(* zadanie 1. *)

let is_palindrome lst =
  let rec aux acc slow fast =
    match slow, fast with
      slow, [] -> acc = slow
    | _::slow, _::[] -> acc = slow
    | s::slow, _::_::fast -> aux (s::acc) slow fast
  in aux [] lst lst;;
  
is_palindrome [1;2;1] = true;;
is_palindrome ['a';'b';'b';'a'] = true;;
is_palindrome [2;4;3;2] = false;;
      

(* zadanie 2. *)

type 'a btree = Leaf | Node of 'a btree * 'a * 'a btree

let is_balanced t =
  let rec aux = function
    | Leaf -> (true, 0)
    | Node (l, _, r) -> let l_info = aux l and r_info = aux r
                        in let diff = snd l_info - snd r_info
                           in (fst l_info && fst r_info &&
                                 diff >= -1 && diff <= 1,
                               snd l_info + snd r_info + 1)
  in fst (aux t);;

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
  

(* testy *)
  
is_balanced (Node ((Node ((Node ((Node (Leaf, 3, Leaf)), 2, Leaf)), 1, Leaf)), 0, Leaf)) = false;;
is_balanced Leaf = true;;
is_balanced (Node (Leaf, 0, Leaf)) = true;;
is_balanced (Node (Leaf, 0, Node (Leaf, 1, Node (Leaf, 2, Leaf)))) = false;;
is_balanced (Node (Leaf, 0, Node (Leaf, 1, Leaf))) = true;;

preorder (Node ((Node ((Node ((Node (Leaf, 3, Leaf)), 2, Leaf)), 1, Leaf)), 0, Leaf)) = [0;1;2;3];;
preorder Leaf = [];;
preorder (Node (Leaf, 1, Leaf)) = [1];;

preorder (create_btree [1;2;3;4]) = [1;2;3;4];;
preorder (create_btree [1]) = [1];;
create_btree [] = Leaf;;
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

(* zadanie 4. *)
(* rozwiązałem tylko dwa pierwsze podpunkty *)

type formula =
  | Var of char
  | Not of formula
  | And of formula * formula
  | Or of formula * formula;;

type taut_result = True | False of (char * bool) list;;
  
let uniq lst = List.fold_left (fun acc e -> if List.mem e acc then acc else e::acc) [] lst;;
  
let extract_vars f =
  let rec aux acc = function
    | Var v -> v::acc
    | Not f -> aux acc f
    | And (f1, f2) -> aux (aux acc f2) f1
    | Or (f1, f2) -> aux (aux acc f2) f1
  in uniq (aux [] f);;

let eval f vals =
  let rec aux = function
    | Var v -> List.assoc v vals
    | Not f -> not (aux f)
    | And (f1, f2) -> aux f1 && aux f2
    | Or (f1, f2) -> aux f1 || aux f2
  in aux f;;

let is_tautology f =
  let vars = extract_vars f
  in let rec aux vals = function
         [] -> if (eval f vals) then True else False vals
       | v::vars -> let val1 = aux ((v, true)::vals) vars
                    and val2 = aux ((v, false)::vals) vars
                    in match val1, val2 with
                         False vals, _ -> False vals
                       | _, False vals -> False vals
                       | True, True -> True
     in aux [] vars;;
  
let rec nnf = function
  | Var v -> Var v
  | Not f -> (match f with
                Var v -> Not (Var v)
              | Not f -> nnf f
              | And (f1, f2) -> Or (nnf (Not f1), nnf (Not f2))
              | Or (f1, f2) -> And (nnf (Not f1), nnf (Not f2)))
  | And (f1, f2) -> And (nnf f1, nnf f2)
  | Or (f1, f2) -> Or (nnf f1, nnf f2);;
  
(* testy *)
  
let f1 = Or (Var 'a', Not (Var 'b'));;
let taut = Not (Not (Or (Var 'a', Not (Var 'a'))));;
let f2 = Or (And (Var 'a', Var 'b'), Not (And (Var 'c', And (Var 'd', Var 'e'))));;
extract_vars f1 = ['b';'a'];;
is_tautology f1;;
is_tautology taut = True;;
nnf taut = Or (Var 'a', Not (Var 'a'));;
nnf f2 = Or (And (Var 'a', Var 'b'), Or (Not (Var 'c'), Or (Not (Var 'd'), Not (Var 'e'))));;


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

