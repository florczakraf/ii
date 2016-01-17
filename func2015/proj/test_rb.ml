open Rb;;
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
module R = Rb(Bint);;

let graphics () =
  let r = R.empty ()
  in Draw.draw (module R) r; let r = R.insert 5 r
  in Draw.draw (module R) r; let r = R.insert 6 r
  in Draw.draw (module R) r; let r = R.insert 7 r
  in Draw.draw (module R) r; let r = R.insert 8 r
  in Draw.draw (module R) r; let r = R.insert 4 r
  in Draw.draw (module R) r; let r = R.insert 3 r
  in Draw.draw (module R) r; let r = R.insert 2 r
  in Draw.draw (module R) r; let r = R.insert 1 r
  in Draw.draw (module R) r;
  let r = R.delete 7 r
  in Draw.draw (module R) r


let operations () =
  print_endline "testing rb operations ->";
  let r = R.empty () in
  test_assert "  is_empty on empty" (R.is_empty r) &&
  test_equals "  depth on empty" (R.depth r) 0 &&
  test_equals "  delete on empty" (R.delete 3 r) r &&
  test_assert_false "  search on empty" (R.search 5 r) &&
  test_failure "  min on empty" (fun () -> R.min r) &&
  test_failure "  max on empty" (fun () -> R.max r) &&
  let r1 = R.insert 4 r in
  test_assert_false "  is_empty on nonempty" (R.is_empty r1) &&
  test_equals "  depth on nonempty" (R.depth r1) 1 &&
  let r2 = R.insert 6 r1 in
  let r3 = R.insert 7 r2 in
  test_assert_false "  nonexistent search" (R.search 8 r3) &&
  test_assert "  existent search" (R.search 4 r3) &&
  test_equals "  depth" (R.depth r3) 2 &&
  let r4 = R.delete 6 r3 in
  test_assert_false "  delete" (R.search 6 r4) &&
  test_equals "  min" (R.min r3) 4 &&
  test_equals "  max" (R.max r3) 7
        
let main () =
  assert (operations ());
  print_endline "Done. Time for drawing tests (any key to progress)..";
  graphics ()
    
let _ = main ()
 
