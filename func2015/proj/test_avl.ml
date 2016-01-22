open Avl;;
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
module A = Avl(Bint);;

let graphics () =
  let a = A.empty ()
  in Draw.draw (module A) a; let a = A.insert 5 a
  in Draw.draw (module A) a; let a = A.insert 6 a
  in Draw.draw (module A) a; let a = A.insert 7 a
  in Draw.draw (module A) a; let a = A.insert 8 a
  in Draw.draw (module A) a; let a = A.insert 4 a
  in Draw.draw (module A) a; let a = A.insert 3 a
  in Draw.draw (module A) a; let a = A.insert 2 a
  in Draw.draw (module A) a; let a = A.insert 1 a
  in Draw.draw (module A) a; let a = A.delete 7 a
  in Draw.draw (module A) a; let a = A.delete 4 a
  in Draw.draw (module A) a; let a = A.delete 3 a
  in Draw.draw (module A) a; let a = A.delete 2 a
  in Draw.draw (module A) a; let a = A.delete 6 a
  in Draw.draw (module A) a; let a = A.delete 1 a
  in Draw.draw (module A) a


let operations () =
  print_endline "testing avl operations ->";
  let a = A.empty () in
  test_assert "  is_empty on empty" (A.is_empty a) &&
  test_equals "  depth on empty" (A.depth a) 0 &&
  test_equals "  delete on empty" (A.delete 3 a) a &&
  test_assert_false "  search on empty" (A.search 5 a) &&
  test_failure "  min on empty" (fun () -> A.min a) &&
  test_failure "  max on empty" (fun () -> A.max a) &&
  let a1 = A.insert 4 a in
  test_assert_false "  is_empty on nonempty" (A.is_empty a1) &&
  test_equals "  depth on nonempty" (A.depth a1) 1 &&
  let a2 = A.insert 6 a1 in
  let a3 = A.insert 7 a2 in
  test_assert_false "  nonexistent search" (A.search 8 a3) &&
  test_assert "  existent search" (A.search 4 a3) &&
  test_equals "  depth" (A.depth a3) 2 &&
  let a4 = A.delete 6 a3 in
  test_assert_false "  delete" (A.search 6 a4) &&
  test_equals "  min" (A.min a3) 4 &&
  test_equals "  max" (A.max a3) 7
        
let main () =
  assert (operations ());
  print_endline "Done. Time for drawing tests (any key to progress)..";
  graphics ()
    
let _ = main ()
 
