module type BINTREE =
sig
  module E : Comparable.COMPARABLE
  type e = E.t
  type tree = Leaf | Node of tree * e * tree

  val depth: tree -> int
end



module Bintree (E : Comparable.COMPARABLE) : BINTREE with module E = E =
struct
  module E = E
  type e = E.t
  type tree = Leaf | Node of tree * e * tree

  let rec depth = function
    | Leaf -> 0
    | Node (l, _, r) -> max (depth l) (depth r) + 1
end

  (*testy*)(*
module Int : COMPARABLE with type t = int =
struct
  type t = int
             
  let str = string_of_int
end;;
  
module B = Bintree(Int);;*)
