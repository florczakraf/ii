open Bintree;;

module type BST =
sig
  module T : BINTREE
  type tree = T.tree
  type e = T.E.t
  type t = T.tree
                
  val empty: unit -> tree
  val depth: tree -> int
  val is_empty: tree -> bool
  val insert: e -> tree -> tree
  val delete: e -> tree -> tree
  val search: e -> tree -> bool
  val max: tree -> e
  val min: tree -> e
                     (*  val draw_tree: tree -> unit*)
  val to_bintree: t -> tree
end;;

module Bst (T : BINTREE) : BST with module T = T =
struct
  module T = T
  type tree = T.tree
  type e = T.E.t
  type t = T.tree

  let empty () = T.Leaf

  let to_bintree t = t
                   
  let is_empty = function
    | T.Leaf -> true
    | _ -> false

  let rec depth = T.depth

  let search e t =
    let rec aux = function
      | T.Leaf -> false
      | T.Node (l, v, r) -> let cmp = T.E.cmp v e
                            in if cmp = 0 then true
                               else if cmp < 0 then aux r
                               else aux l
    in aux t
           
  let rec insert e t = match t with
      T.Leaf -> T.Node (T.Leaf, e, T.Leaf)
    | T.Node (l, v, r) -> let cmp = T.E.cmp v e
                          in if cmp = 0 then t
                             else if cmp < 0 then T.Node (l, v, insert e r)
                             else T.Node (insert e l, v, r)

  let rec max = function
    | T.Leaf -> failwith "Tree is empty"
    | T.Node (_, v, T.Leaf) -> v
    | T.Node (_, _, r) -> max r

  let rec min = function
    | T.Leaf -> failwith "Tree is empty"
    | T.Node (T.Leaf, v, _) -> v
    | T.Node (l, _, _) -> min l
                            
  let rec delete e = function
    | T.Leaf -> T.Leaf
    | T.Node (l, v, r) -> let cmp = T.E.cmp v e
                          in if cmp = 0 then
                               match l, r with
                                 T.Leaf, T.Leaf -> T.Leaf
                               | T.Node _, T.Leaf -> l
                               | T.Leaf, T.Node _ -> r
                               | _ -> let lmax = max l
                                      in T.Node (delete lmax l, lmax, r)
                             else if cmp < 0 then T.Node (l, v, delete e r)
                             else T.Node (delete e l, v, r)

end;;
