open Bintree;;

module type RB =
sig
  module T : BINTREE
  type tree = T.tree
  type e = T.E.t
  type t
  type color = R | B | BB
                
  val empty: unit -> t
  val depth: t -> int
  val is_empty: t -> bool
  val insert: e -> t -> t
  val delete: e -> t -> t
  val search: e -> t -> bool

  val to_bintree: t -> tree
end;;

module Rb (T : BINTREE) : RB with module T = T =
struct
  module T = T
  type tree = T.tree
  type e = T.E.t
  type color = R | B | BB
  type t = Leaf of color | Node of color * t * e * t

  let empty () = Leaf B

  let rec to_bintree = function
    | Leaf _ -> T.Leaf
    | Node (_, l, v, r) -> T.Node (to_bintree l, v, to_bintree r)
    
  let is_empty = function
    | Leaf _ -> true
    | _ -> false

  let rec depth = function
    | Leaf _ -> 0
    | Node (_, l, _, r) -> max (depth l) (depth r) + 1


  let search e t =
    let rec aux = function
      | Leaf _ -> false
      | Node (_, l, v, r) -> let cmp = T.E.cmp v e
                            in if cmp = 0 then true
                               else if cmp < 0 then aux r
                               else aux l
    in aux t
           
  let insert_balance_l c l v r =
    match c, l with
      B, Node (R, Node (R, lll, llv, llr), lv, lr) -> Node (R, Node (B, lll, llv, llr), lv, Node (B, lr, v, r))
    | B, Node (R, ll, lv, Node (R, lrl, lrv, lrr)) -> Node (R, Node (B, ll, lv, lrl), lrv, Node (B, lrr, v, r))
    | _ -> Node (c, l, v, r)


  let insert_balance_r c l v r =
    match c, r with
      B, Node (R, rl, rv, Node (R, rrl, rrv, rrr)) -> Node (R, Node (B, l, v, rl), rv, Node (B, rrl, rrv, rrr))
    | B, Node (R, Node (R, rll, rlv, rlr), rv, rr) -> Node (R, Node (B, l, v, rll), rlv, Node (B, rlr, rv, rr))
    | _ -> Node (c, l, v, r)

  let insert e t =
    let rec aux = function
      | Leaf _ -> Node (R, Leaf B, e, Leaf B)
      | Node (c, l, v, r) ->
         let cmp = T.E.cmp v e
         in if cmp = 0 then Node (c, l, v, r)
            else if cmp < 0 then insert_balance_r c l e (aux r)
            else insert_balance_l c (aux l) e r
    in match aux t with
       | Leaf _ -> assert false
       | Node (_, l, v, r) -> Node (B, l, v, r)
                             

  let rec min = function
    | Leaf _ -> failwith "Tree is empty"
    | Node (_, Leaf _, v, _) -> v
    | Node (_, l, _, _) -> min l

  let rec max = function
    | Leaf _ -> failwith "Tree is empty"
    | Node (_, _, v, Leaf _) -> v
    | Node (_, _, _, r) -> max r

  let add_b = function
    | Leaf B -> Leaf BB
    | Node (B, l, v, r) -> Node (BB, l, v, r)
    | Node (R, l, v, r) -> Node (B, l, v, r)
    | _ -> assert false

  let remove_b = function
    | Leaf BB -> Leaf B
    | Node (BB, l, v, r) -> Node (B, l, v, r)
    | _ -> assert false
                               
  let is_bb = function
    | Leaf BB
    | Node (BB, _, _, _) -> true
    | _ -> false

  let is_b = function
    | Leaf B
    | Node (B, _, _, _) -> true
    | _ -> false

  let is_r = function
    | Node (R, _, _, _) -> true
    | _ -> false

  let value = function
    | Node (_, _, v, _) -> v
    | _ -> assert false

  let left = function
    | Node (_, l, _, _) -> l
    | _ -> assert false

  let right = function
    | Node (_, _, _, r) -> r
    | _ -> assert false
    
  let rec delete_balance_l = function
    | Node (B, l, v, Node (R, rl, rv, rr)) as node ->
       if is_bb l then
         Node (B, delete_balance_l (Node (R, l, v, rl)), rv, rr)
       else node
    | Node (c, l, v, Node (B, rl, rv, rr)) as node ->
       if is_bb l
       then
         if is_b rl && is_b rr then
           add_b (Node (c, remove_b l, v, Node (R, rl, rv, rr)))
         else if is_r rl && is_b rr then
           delete_balance_l (Node (c, l, v, Node (B, left rl, value rl, Node (R, right rl, rv, rr))))
         else
           Node (c, Node (B, remove_b l, v, rl), rv, add_b rr)
       else
         node
    | Node (c, l, v, r) -> Node (c, l, v, r)
                                   
end;;
