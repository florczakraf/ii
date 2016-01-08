module type COMPARABLE =
sig
  type t

  val cmp: t -> t -> int
  val str: t -> string
end
  
