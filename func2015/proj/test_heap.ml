open Comparable;;
open Bintree;;
open Heap;;
open Helpers;;

module Int : COMPARABLE with type t = int =
struct
  type t = int

  let cmp = compare
  let str = string_of_int
end;;

module Bint = Bintree(Int);;
module H = Heap(Bint);;

let graphics () =
  let h = H.empty () in
  let h = H.insert (-3) h in Draw.draw (module H) h;
  let h = H.insert 50 h in Draw.draw (module H) h;
  let h = H.insert 13 h in Draw.draw (module H) h;
  let h = H.insert 103 h in Draw.draw (module H) h;
  let h = H.insert (-6) h in Draw.draw (module H) h;
  let h = H.insert 0 h in Draw.draw (module H) h;                               
  let h = H.insert 1 h in Draw.draw (module H) h;
  let h = H.insert 52 h in Draw.draw (module H) h;
  let h = H.insert 47 h in Draw.draw (module H) h;
  let h = H.insert 42 h in Draw.draw (module H) h;
  let h = H.insert (-33) h in Draw.draw (module H) h;
  let h = H.insert 666 h in Draw.draw (module H) h;
  let h = H.delete_min h in Draw.draw (module H) h;
  let h = H.delete_min h in Draw.draw (module H) h;
  let h = H.delete_min h in Draw.draw (module H) h;
  let h = H.delete_min h in Draw.draw (module H) h;
  let h = H.delete_min h in Draw.draw (module H) h;
  let h = H.delete_min h in Draw.draw (module H) h;
  let h = H.delete_min h in Draw.draw (module H) h;
  let h = H.delete_min h in Draw.draw (module H) h;
  let h = H.delete_min h in Draw.draw (module H) h


                                    
let operations () =
  print_endline ("testing operations on heap ->");
  let h = H.empty () in
  test_failure "  min on empty" (fun () -> H.min h)
  &&
  test_failure "  delete_min on empty" (fun () -> H.delete_min h)
  &&
  let h = H.empty () in
  let h1 = H.insert 4 h in
  let h2 = H.insert 5 h1 in
  let h3 = H.insert 8 h2 in
  let h4 = H.insert 1 h3 in
  test_equals "  min on non-empty" (H.min h4) 1
  &&
  test_equals "  delete_min on on-empty" (H.delete_min h4) h3
  
let main () =
  assert (operations ());
  print_endline "Done. Time for drawing tests (any key to progress)..";
  graphics ();;
  
let _ = main ();;
