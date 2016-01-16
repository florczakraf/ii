open Bintree;;

module type SPLAY =
sig
  module T : BINTREE
  type tree = T.tree
  type e = T.E.t
  type t = tree ref
                
  val empty: unit -> t
  val depth: t -> int
  val is_empty: t -> bool
  val insert: e -> t -> t
  val delete: e -> t -> t
  val search: e -> t -> bool
  val max: tree -> e
  val min: tree -> e

  val to_bintree: t -> tree
end;;

module Splay (T : BINTREE) : SPLAY with module T = T =
struct
  module T = T
  type tree = T.tree
  type e = T.E.t
  type t = tree ref

  let empty () = ref T.Leaf

  let to_bintree t = !t
                   
  let is_empty t =
    match !t with
    | T.Leaf -> true
    | _ -> false

  let depth t = T.depth !t
           
  let rec max = function
    | T.Leaf -> failwith "Tree is empty"
    | T.Node (_, v, T.Leaf) -> v
    | T.Node (_, _, r) -> max r

  let rec min = function
    | T.Leaf -> failwith "Tree is empty"
    | T.Node (T.Leaf, v, _) -> v
    | T.Node (l, _, _) -> min l

  let rec splay e t =
    match t with
      T.Leaf -> T.Leaf
    | T.Node (l, v, r) ->
       let cmpev = T.E.cmp e v in
       if cmpev = 0 then                                  (*= e = v =*)
         t
       else if cmpev < 0 then                             (*= e < v =*)
         match l with
           T.Leaf -> t
         | T.Node (ll, lv, lr) ->
            let cmpelv = T.E.cmp e lv in
            if cmpelv = 0 then                            (* e = lv *)
              T.Node (ll, lv, T.Node (lr, v, r))
            else if cmpelv < 0 then                       (* e < lv *)
              match ll with
                T.Leaf -> T.Node (ll, lv, T.Node (lr, v, r))
              | _ -> match splay e ll with
                       T.Leaf -> assert false
                     | T.Node (l', v', r') ->
                        T.Node (l', v', T.Node (r', lv, T.Node (lr, v, r)))
            else                                          (* e > lv *)
              match lr with
                T.Leaf -> T.Node (ll, lv, T.Node (lr, v, r))
              | _ -> match splay e lr with
                       T.Leaf -> assert false
                     | T.Node (l', v', r') ->
                        T.Node (T.Node (ll, lv, l'), v', T.Node (r', v, r))
       else                                               (*= e > v =*)
         match r with
           T.Leaf -> t
         | T.Node (rl, rv, rr) ->
            let cmperv = T.E.cmp e rv in
            if cmperv = 0 then                            (* e = rv *)
              T.Node (T.Node (l, v, rl), rv, rr)
            else if cmperv < 0 then                       (* e < rv*)
              match rl with
                T.Leaf -> T.Node (T.Node (l, v, rl), rv, rr)
              | _ -> match splay e rl with
                       T.Leaf -> assert false
                     | T.Node (l', v', r') ->
                        T.Node (T.Node (l, v, l'), v', T.Node (r', rv, rr))
            else
              match rr with
              | T.Leaf -> T.Node (T.Node (l, v, rl), rv, rr)
              | _ -> match splay e rr with
                       T.Leaf -> assert false
                     | T.Node (l', v', r') ->
                        T.Node (T.Node (T.Node (l, v, rl), rv, l'), v', r')
                     
  let value = function
    | T.Leaf -> failwith "Tree is empty"
    | T.Node (_, v, _) -> v

  let search e t =
    match !t with
      T.Leaf -> false
    | _ -> t := splay e !t;
           if T.E.cmp e (value !t) = 0 then
             true
           else
             false

  let insert e t =
    match !t with
      T.Leaf -> ref (T.Node (T.Leaf, e, T.Leaf))
    | _ ->
       match splay e !t with
         T.Leaf -> assert false
       | T.Node (l, v, r) ->
          let cmp = T.E.cmp e v in
          if cmp = 0 then               (* e = v *)
            ref (T.Node (l, v, r))
          else if cmp < 0 then          (* e < v *)
            ref (T.Node (l, e, T.Node (T.Leaf, v, r)))
          else                          (* e > v *)
            ref (T.Node (T.Node (l, v, T.Leaf), e, r))


  let delete e t =
    match !t with
      T.Leaf -> ref T.Leaf
    | _ -> match splay e !t with
             T.Leaf -> assert false
           | T.Node (l, v, r) ->
              if T.E.cmp e v = 0 then
                match l, r with
                  T.Leaf, _ -> ref r
                | _, T.Leaf -> ref l
                | _, _ -> match splay e l with
                            T.Leaf -> assert false
                          | T.Node (l', v', r') ->
                             ref (T.Node (l', v', r))
              else
                ref (T.Node (l, v, r))
                
end;;
  
