open Bintree;;

module type AVL =
sig
  module T : BINTREE
  type tree = T.tree
  type e = T.E.t
  type t
                
  val empty: unit -> t
  val depth: t -> int
  val is_empty: t -> bool
  val insert: e -> t -> t
  val delete: e -> t -> t
  val search: e -> t -> bool
  val min: t -> e
  val max: t -> e

  val to_bintree: t -> tree
end;;

module Avl (T : BINTREE) : AVL with module T = T =
struct
  module T = T
  type tree = T.tree
  type e = T.E.t
  type t = Leaf | Node of int * t * e * t

  let empty () = Leaf

  let rec to_bintree = function
    | Leaf -> T.Leaf
    | Node (_, l, v, r) -> T.Node (to_bintree l, v, to_bintree r)
                   
  let is_empty = function
    | Leaf -> true
    | _ -> false

  let depth = function
    | Leaf -> 0
    | Node (d, _, _, _) -> d

  let search e t =
    let rec aux = function
      | Leaf -> false
      | Node (_, l, v, r) -> let cmp = T.E.cmp v e
                             in if cmp = 0 then
                                  true
                                else if cmp < 0 then
                                  aux r
                                else
                                  aux l
    in aux t

  let depth_diff l r = depth l - depth r
           
  let diff = function
    | Leaf -> 0
    | Node (_, l, _, r) -> depth_diff l r
                                           
  let make_node l v r = Node (1 + max (depth l) (depth r), l, v, r)

  let balance l v r =
    let diff_lr = depth_diff l r
    in if abs diff_lr <= 1 then
         make_node l v r
       else if diff_lr = 2 then
         match l with
           Leaf -> assert false
         | Node (_, ll, lv, lr) -> if depth_diff ll lr = (-1) then
                                     match lr with
                                       Leaf -> assert false
                                     | Node (_, lrl, lrv, lrr) ->
                                        make_node (make_node ll lv lrl) lrv (make_node lrr v r)
                                   else make_node ll lv (make_node lr v r)
       else
         match r with
           Leaf -> assert false
         | Node (_, rl, rv, rr) -> if depth_diff rl rr = 1 then
                                     match rl with
                                       Leaf -> assert false
                                     | Node (_, rll, rlv, rlr) ->
                                        make_node (make_node l v rll) rlv (make_node rlr rv rr)
                                   else
                                     make_node (make_node l v rl) rv rr
                                                     
                                                     
  let rec insert e t = match t with
      Leaf -> make_node Leaf e Leaf
    | Node (_, l, v, r) -> let cmp = T.E.cmp v e
                           in if cmp = 0 then
                                t
                              else if cmp > 0 then
                                balance (insert e l) v r
                              else
                                balance l v (insert e r)


  let rec max = function
    | Leaf -> failwith "Tree is empty"
    | Node (_, _, v, Leaf) -> v
    | Node (_, _, _, r) -> max r

  let rec min = function
    | Leaf -> failwith "Tree is empty"
    | Node (_, Leaf, v, _) -> v
    | Node (_, l, _, _) -> min l
                            
  let rec delete e = function
    | Leaf -> Leaf
    | Node (_, l, v, r) -> let cmp = T.E.cmp v e
                           in if cmp = 0 then
                                match l, r with
                                  Leaf, Leaf -> Leaf
                                | Node _, _ -> let lmax = max l in
                                               balance (delete lmax l) lmax r
                                | _, Node _ -> let rmin = min r in
                                               balance l rmin (delete rmin r)
                              else if cmp < 0 then balance l v (delete e r)
                              else balance (delete e l) v r
                                          
end;;
