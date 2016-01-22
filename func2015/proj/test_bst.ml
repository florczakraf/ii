open Bst;;
open Comparable;;
open Bintree;;
open Helpers;;
  
module Int : COMPARABLE with type t = int =
struct
  type t = int

  let cmp = compare
  let str = string_of_int
end;;

module Bint = Bintree(Int);;
module B = Bst(Bint);;

let graphics () =
  let b = B.empty ()
  in let b = B.insert 6 b
  in Draw.draw (module B) b; let b = B.insert 7 b
  in Draw.draw (module B) b; let b = B.insert 5 b
  in Draw.draw (module B) b; let b = B.insert 8 b
  in Draw.draw (module B) b; let b = B.insert 4 b
  in Draw.draw (module B) b; let b = B.insert 2 b
  in Draw.draw (module B) b; let b = B.insert 3 b
  in Draw.draw (module B) b; let b = B.insert 1 b
  in Draw.draw (module B) b; let b = B.delete 2 b
  in Draw.draw (module B) b; let b = B.delete 6 b
  in Draw.draw (module B) b; let b = B.delete 1 b
  in Draw.draw (module B) b; let b = B.delete 8 b
  in Draw.draw (module B) b; let b = B.delete 4 b
  in Draw.draw (module B) b; let b = B.delete 5 b
  in Draw.draw (module B) b


let operations () =
  print_endline "testing bst operations ->";
  let b = B.empty () in
  test_assert "  is_empty on empty" (B.is_empty b) &&
  test_equals "  depth on empty" (B.depth b) 0 &&
  test_equals "  delete on empty" (B.delete 3 b) b &&
  test_assert_false "  search on empty" (B.search 5 b) &&
  test_failure "  min on empty" (fun () -> B.min b) &&
  test_failure "  max on empty" (fun () -> B.max b) &&
  let b1 = B.insert 4 b in
  test_assert_false "  is_empty on nonempty" (B.is_empty b1) &&
  test_equals "  depth on nonempty" (B.depth b1) 1 &&
  let b2 = B.insert 6 b1 in
  let b3 = B.insert 7 b2 in
  test_assert_false "  nonexistent search" (B.search 8 b3) &&
  test_assert "  existent search" (B.search 4 b3) &&
  test_equals "  depth" (B.depth b3) 3 &&
  let b4 = B.delete 6 b3 in
  test_assert_false "  delete" (B.search 6 b4) &&
  test_equals "  min" (B.min b3) 4 &&
  test_equals "  max" (B.max b3) 7 
        
let main () =
  assert (operations ());
  print_endline "Done. Time for drawing tests (any key to progress)..";
  graphics ()
    
let _ = main ()
 
