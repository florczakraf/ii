module type BINTREE =
sig
  module E : Comparable.COMPARABLE
  type e = E.t
  type tree = Leaf | Node of tree * e * tree

  val depth: tree -> int
end

module Bintree (E : Comparable.COMPARABLE) : BINTREE with module E = E
