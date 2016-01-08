(* Heap implemented as leftist tree *)
open Bintree;;

module type HEAP =
sig
  module T : BINTREE
  type tree = T.tree
  type e = T.E.t
  type t

  val empty: unit -> t
  val rank: t -> int
  val merge: t -> t -> t
  val is_empty: t -> bool
  val insert: e -> t -> t
  val delete_min: t -> t
  val min: t -> e
  val to_tree: t -> tree
end;;
  
module Heap (T : BINTREE) : HEAP with module T = T =
struct
  module T = T
  type tree = T.tree
  type e = T.E.t
  type t = Leaf | Node of int * t * e * t

  let empty () = Leaf
                   
  let rec to_tree = function
    | Leaf -> T.Leaf
    | Node (_, l, v, r) -> T.Node (to_tree l, v, to_tree r)
                                 
  let is_empty = function
    | Leaf -> true
    | _ -> false

  let rank = function
    | Leaf -> 0
    | Node (r, _, _, _) -> r

  let single v = Node (1, Leaf, v, Leaf)

  let rec merge lt rt =
    match lt, rt with
      Leaf, t -> t
    | t, Leaf -> t
    | Node (_, ll, lv, lr), Node (_, _, rv, _) ->
       if lv > rv then merge rt lt
       else
         let merged = merge lr rt
         in let lrank = rank ll and rrank = rank merged
            in if lrank >= rrank
               then Node (rrank + 1, ll, lv, merged)
               else Node (lrank + 1, merged, lv, ll)

  let insert v h = merge h (single v)
      
  let min  = function
    | Leaf -> failwith "Heap is empty"
    | Node (_, _, v, _) -> v

  let delete_min = function
    | Leaf -> failwith "Heap is empty"
    | Node (_, l, _, r) -> merge l r

end;;
