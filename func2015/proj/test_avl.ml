
(*ocamlc graphics.cma draw.cmo bintree.cmo avl.cmo test_avl.ml*)

open Avl;;
open Comparable;;
open Bintree;;
  
module Int : COMPARABLE with type t = int =
struct
  type t = int

  let cmp = compare
  let str = string_of_int
end;;

module Bint = Bintree(Int);;
module A = Avl(Bint);;

let main () =
  let a = A.empty ()
  in let a = A.insert 1 a
  in let a = A.insert 2 a
  in let a = A.insert 3 a
  in let a = A.insert 4 a
  in let a = A.insert 5 a
  in let a = A.insert 6 a
  in let a = A.insert 7 a
  in let a = A.insert 8 a
     in Draw.draw (module A) a

    
let _ = main ()
 
