open Comparable

module type HEAP =
sig
  type e
  type tree
  type heap

  val empty: unit -> heap
  val rank: heap -> int
  val merge: heap -> heap -> heap
  val is_empty: heap -> bool
  val insert: e -> heap -> heap
  val delete_min: heap -> heap
  val min: heap -> e
  val draw: heap -> unit
  val to_tree: heap -> tree                    
end;;

module Heap (E : COMPARABLE) : HEAP with type e = E.t
                                                    
