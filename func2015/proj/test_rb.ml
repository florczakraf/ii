
(*ocamlc graphics.cma draw.cmo bintree.cmo rb.cmo test_rb.ml*)

open Rb;;
open Comparable;;
open Bintree;;
  
module Int : COMPARABLE with type t = int =
struct
  type t = int

  let cmp = compare
  let str = string_of_int
end;;

module Bint = Bintree(Int);;
module R = Rb(Bint);;

let main () =
  let r = R.empty ()
  in let r = R.insert 1 r in
  Draw.draw (module R) r;
  let r = R.insert 2 r in
  Draw.draw (module R) r;
  let r = R.insert 3 r in
  Draw.draw (module R) r;
  let r = R.insert 4 r in
  Draw.draw (module R) r;
  let r = R.insert 5 r in
  Draw.draw (module R) r;
  let r = R.insert 6 r in
  Draw.draw (module R) r;
  let r = R.insert 7 r in
  Draw.draw (module R) r;
  let r = R.insert 8 r in
  Draw.draw (module R) r

    
let _ = main ()
 
