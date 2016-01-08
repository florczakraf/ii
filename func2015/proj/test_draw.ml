open Bst;;
open Comparable;;
open Bintree;;
  
module Int : COMPARABLE with type t = int =
struct
  type t = int
             
  let str = string_of_int
end;;

module Bint = Bintree(Int);;
module B = Bst(Bint);;

let main () =
  let b = B.empty ()
  in let b = B.insert 1 b
  in let b = B.insert 2 b
  in let b = B.insert 3 b
  in let b = B.insert 1 b
  in let b = B.insert 8 b
  in let b = B.insert 6 b
  in let b = B.insert 7 b
  in let b = B.insert 9 b
  in Draw.draw (module B) b

    
let _ = main ()
                         
