open Comparable;;
open Bintree;;
open Heap;;

module Int : COMPARABLE with type t = int =
struct
  type t = int
             
  let str = string_of_int
end;;

module Bint = Bintree(Int);;
module H = Heap(Bint);;

let main () =
  let h = H.empty () in
  let h = H.insert 3 h in
  let h = H.insert 1 h in
  let h = H.insert 7 h in
  let h = H.insert 4 h in
  let h = H.insert 2 h in
  let h = H.insert (-4) h in
  let h = H.insert 9 h in
  print_int (H.min h);
  let h = H.delete_min h in
  print_int (H.min h);
  H.draw h;;

let _ = main ();;
