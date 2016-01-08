module type COMPARABLE =
sig
  type t

  val str: t -> string
  (* I assume that t will have properly defined comaprison operators. *)
end
  
