type htree = Leaf of char * float | Node of htree * float * htree;;

let freq = function
  | Leaf (_, f) -> f
  | Node (_, f, _) -> f;;

let cmp a b =
  let fa = freq a and fb = freq b
  in if fa < fb then -1
     else if fa > fb then 1
     else 0;;
  
let make_tree freqs =
  let leafs = List.map (fun (c, f) -> Leaf (c, f)) freqs
  in let sorted = List.sort cmp leafs
     in let rec aux = function
          | [] -> assert false
          | [x] -> [x]
          | a::b::tl -> let fa = freq a and fb = freq b
                        in if fa > fb then aux (List.merge cmp [Node (a, fa +. fb , b)] tl)
                           else aux (List.merge cmp [Node (b, fa +. fb , a)] tl)
        in List.hd (aux sorted);;

let rec dfs acc = function
  | Leaf (c, _) -> [(List.rev acc, c)]
  | Node (l, _, r) -> (dfs (0::acc) l) @ (dfs (1::acc) r);;

let codes tree = dfs [] tree;;

let rec encode codes lst =
  let rec aux = function
    | [] -> []
    | h::t -> fst (List.find (fun (_, char) -> h = char) codes) :: (aux t)
  in List.flatten (aux lst);;

let decode tree lst =
  let rec aux acc lst t =
    match lst, t with
      [], Leaf (c, _) -> List.rev (c::acc)
    | lst, Leaf (c, _) -> aux (c::acc) lst tree
    | h::t, Node (l, _, r) -> if h = 0 then aux acc t l
                              else aux acc t r
  in aux [] lst tree;;
  
(* testy *)

let freqs = [('k', 0.125);('o', 0.25);('r', 0.25);('m', 0.125);('a', 0.125);('n', 0.125)];;
  
let tree = make_tree freqs;;

let coded = codes tree;;

let encoded = encode coded ['k';'o';'r';'m';'o';'r';'a';'n'];;
let encoded2 = encode coded ['m';'a';'r';'o';'k';'o'];;
decode tree encoded;;
decode tree encoded2;; 

  
